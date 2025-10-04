# Judge0 AI Agent Instructions

## Project Overview

Judge0 is a **robust, scalable, and open-source online code execution system** built with Ruby on Rails. It provides sandboxed compilation and execution of code in 60+ languages via a REST API. The system uses **Isolate** (a Linux sandbox) for secure code execution and **Resque** (Redis-backed) for async job processing.

**Key Architecture:**
- **API Server** (`server` service): Rails API handling HTTP requests
- **Workers** (`worker` service): Resque workers executing code in Isolate sandboxes
- **Database**: PostgreSQL for submission/language metadata
- **Queue**: Redis for Resque job queue
- **Sandbox**: Isolate (Linux cgroups-based) for secure code execution

## Critical Development Knowledge

### System Architecture Flow

1. **Submission Creation** → `SubmissionsController#create` → Validates input, saves to DB, enqueues job
2. **Job Processing** → `IsolateJob#perform` → Compiles/runs code in Isolate sandbox, updates DB
3. **Result Retrieval** → `SubmissionsController#show` → Returns cached submission from DB

**Synchronous execution** (`wait=true`): `IsolateRunner.perform_now` polls DB until completion (max 600s).

### Isolate Sandbox Integration

**Core concept**: All code execution happens in **Isolate** sandboxes, identified by `box_id = submission.id % 2147483647`.

**Execution phases** (see `IsolateJob`):
1. **Initialize**: `isolate --init` creates `/tmp/box/{box_id}/{box,tmp}/`
2. **Compile** (if needed): Runs `compile.sh` or language's `compile_cmd` in sandbox
3. **Run**: Executes `run.sh` or `run_cmd` with stdin/stdout/stderr redirection
4. **Verify**: Parses `metadata.txt` for time/memory/exit status
5. **Cleanup**: `isolate --cleanup` destroys sandbox

**Important**: File permissions require `sudo` - scripts use `sudo chown/rm` extensively.

### Base64 Encoding Convention

**All text fields** (`source_code`, `stdin`, `stdout`, `stderr`, `compile_output`, `expected_output`) are **stored as Base64** in the database but **exposed as UTF-8** via the API by default.

- **Setter pattern**: `def source_code=(value); self[:source_code] = Base64Service.encode(value); end`
- **Getter pattern**: `def source_code; Base64Service.decode(self[:source_code]); end`
- **API behavior**: `base64_encoded=false` (default unless `DISABLE_IMPLICIT_BASE64_ENCODING=true`) returns decoded UTF-8
- **Why**: Handles binary/non-UTF-8 output safely; prevents encoding errors

### Configuration System

**All runtime config via environment variables** (no hardcoded values). Defined in `app/helpers/config.rb`.

**Pattern**: `ENV["KEY"].presence || default_value` with type coercion (`.to_i`, `.to_f`, `== "true"`).

**Critical configs**:
- `ENABLE_WAIT_RESULT`, `ENABLE_COMPILER_OPTIONS`, `ENABLE_CALLBACKS`, `ENABLE_ADDITIONAL_FILES` - Feature toggles
- `MAX_QUEUE_SIZE`, `MAX_CPU_TIME_LIMIT`, `MAX_MEMORY_LIMIT` - Resource limits
- `JUDGE0_VERSION` - Resque queue namespace (allows multiple versions)

**Never add hardcoded limits** - always add new ENV vars to `Config` module.

### Status Enumeration Pattern

Uses `enumerations` gem for type-safe statuses (see `app/enumerations/status.rb`).

**Lifecycle**: `queue` (1) → `process` (2) → `ac/wa/tle/ce/runtime_error/internal_error` (3-14)

**Access pattern**: `Status.queue`, `Status.ac`, `submission.status = Status.tle`

**Exit signal mapping**: `Status.find_runtime_error_by_status_code(signal)` maps POSIX signals (SIGSEGV=11 → `sigsegv`).

### Batch Operations

Two batch endpoints: `POST /submissions/batch` (create) and `GET /submissions/batch` (retrieve).

**Key difference from single submission**:
- Batch create returns **array of {token} or errors** (partial success allowed)
- Batch show requires `tokens` header/param (comma-separated), returns **array with `nil` for missing**
- **No sync mode** for batch create (`wait` ignored)
- Max batch size: `Config::MAX_SUBMISSION_BATCH_SIZE` (default 20)

### Multi-File Programs

Special language type: `"Multi-file program"` (`is_project=true`).

**Differences**:
- `source_code` must be **absent**, `additional_files` (ZIP archive) **required**
- Execution scripts: `boxdir/compile.sh` or `boxdir/compile`, `boxdir/run.sh` or `boxdir/run` (must be in ZIP)
- Extracted via `unzip -n -qq` in sandbox before compilation

**Validation**: `validates :source_code, absence: true, if: -> { is_project }`

### Caching Strategy

**Rails.cache** (in-memory) caches submissions by token with TTL = `Config::SUBMISSION_CACHE_DURATION` (default 1s).

**Pattern** (see `SubmissionsController#show`):
```ruby
Rails.cache.fetch("#{token}", expires_in: Config::SUBMISSION_CACHE_DURATION, race_condition_ttl: 0.1*Config::SUBMISSION_CACHE_DURATION) {
  Submission.find_by!(token: token)
}
```

**Why short TTL?**: Balances repeated polling (common in UIs) vs fresh data for updated submissions.

## Development Workflows

### Running Locally

**Docker Compose** (primary method):
```bash
docker-compose up -d      # Starts server, workers, db, redis
docker-compose logs -f    # Follow logs
```

**Manual (dev)**:
```bash
# Terminal 1: Start Rails server
./scripts/server

# Terminal 2: Start Resque workers
./scripts/workers

# Prerequisites: PostgreSQL, Redis, Isolate installed
```

### Database Management

```bash
rails db:create db:migrate db:seed  # Loads languages from db/languages/{active,archived}.rb
rails db:reset                      # Drop, recreate, migrate, seed
```

**Language seeds**: Managed in `db/languages/active.rb` (current) and `archived.rb` (deprecated). Each has `id`, `name`, `source_file`, `compile_cmd`, `run_cmd`.

### Testing

Uses **RSpec**. Test structure mirrors `app/`:
- `spec/controllers/` - Controller request specs
- `spec/models/` - Model validations
- `spec/jobs/` - IsolateJob specs (may require Isolate sandbox access)

**Run tests**: `bundle exec rspec` (Note: Full test suite requires Docker/Isolate setup)

### API Testing

**Dummy client** at `/public/dummy-client.html` - HTML form for manual API testing.

**cURL example**:
```bash
# Create submission
TOKEN=$(curl -X POST http://localhost:2358/submissions \
  -H "Content-Type: application/json" \
  -d '{"source_code":"cHJpbnQoIkhlbGxvLCBXb3JsZCEiKQ==","language_id":71,"base64_encoded":true}' \
  | jq -r '.token')

# Get result
curl http://localhost:2358/submissions/$TOKEN?base64_encoded=true
```

## Code Conventions

### Controller Patterns

**Before actions for validation**: `check_wait`, `check_queue_size`, `check_maintenance`, `authorize_request`

**Field filtering**: Uses `Fields::Submission` service to validate/apply `?fields=token,status,stdout` query param.

**Error handling**: Returns JSON errors with appropriate HTTP status (`400`, `422`, `503`).

**Example structure** (see `SubmissionsController`):
```ruby
before_action :check_something, only: [:create]

def create
  # Validate → Save → Enqueue/Process → Render
  if object.save
    handle_async_or_sync_processing
  else
    render json: object.errors, status: :unprocessable_entity
  end
end
```

### Model Patterns

**Validation order**: Presence → Format → Custom methods → Numericality/Inclusion

**Custom validators as private methods**: `language_existence`, `compiler_options_allowed` (see `Submission`)

**Default scope**: Used sparingly - `Language` filters `is_archived: false` globally (use `unscoped` to bypass).

**Callbacks**: `before_create :generate_token` (UUID), `before_validation :set_defaults`

### Job Patterns

**Retry strategy**: `retry_on RuntimeError, wait: 0.1.seconds, attempts: 100` (handles transient Isolate failures).

**Atomic updates**: Update submission status at **start** (`Status.process`) and **end** (`Status.ac/wa/etc`).

**Exception handling**: Catch-all `rescue Exception` sets `Status.boxerr` and cleans up sandbox.

**Command execution**: Backticks `` `command` `` for shell execution (not `system`/`exec` - need stdout capture).

### Security Practices

**Input sanitization** (see `IsolateJob#compile`):
```ruby
compiler_options.to_s.strip.encode("UTF-8", invalid: :replace).gsub(/[$&;<>|`]/, "")
```

**Shell injection prevention**: Dangerous chars (`$`, `;`, `|`, backticks) stripped from `compiler_options`/`command_line_arguments`.

**Isolate flags**: `--cg` (cgroups), `-t` (CPU time), `-m`/`--cg-mem` (memory), `-p` (processes), `-f` (file size), `-d /etc:noexec` (mount restrictions).

**Network isolation**: Default disabled (`--share-net` only if `enable_network=true`).

## Common Pitfalls

1. **Forgetting Base64 encoding**: When adding new text fields to `Submission`, must add getter/setter like `source_code`.
2. **Hardcoding limits**: Always use `Config::CONSTANT` and add new ENV var.
3. **Missing sudo for Isolate cleanup**: File operations in `workdir` often need `sudo chown/rm`.
4. **Incorrect cgroups flag**: Use `--cg-mem` for cgroup-based memory limiting, `-m` for per-process (context: `enable_per_process_and_thread_memory_limit`).
5. **Not handling nil language**: `submission.language` can be nil if `language_id` invalid - always check `language_existence`.
6. **Queue namespace mismatch**: Job queue name is `ENV["JUDGE0_VERSION"]` - ensure workers/server use same value.

## Key Files Reference

- **Submission lifecycle**: `app/controllers/submissions_controller.rb`, `app/jobs/isolate_job.rb`, `app/helpers/isolate_runner.rb`
- **Configuration**: `app/helpers/config.rb`, `judge0.conf` (env file)
- **Models**: `app/models/submission.rb`, `app/models/language.rb`, `app/enumerations/status.rb`
- **Deployment**: `docker-compose.yml`, `Dockerfile`, `scripts/{server,workers}`
- **Initialization**: `config/routes.rb`, `config/initializers/resque.rb`, `db/seeds.rb`
