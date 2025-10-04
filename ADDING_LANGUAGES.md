# 📘 Guia: Como Adicionar Novas Linguagens ao Judge0 Custom

Este guia explica como adicionar novas linguagens ao Judge0 Custom.

---

## 📋 Visão Geral

Para adicionar uma nova linguagem, você precisa:

1. ✅ Instalar o runtime/compilador no Dockerfile
2. ✅ Adicionar a configuração em `db/languages/active.rb`
3. ✅ Rebuild da imagem Docker
4. ✅ Re-seed do banco de dados
5. ✅ Testar a nova linguagem

---

## 🔧 Passo 1: Modificar o Dockerfile.custom

Adicione a instalação do runtime/compilador da linguagem.

### Exemplo: Adicionar Ruby

```dockerfile
# ============================================================
# RUBY 3.2
# ============================================================
RUN cd /tmp && \
    wget https://cache.ruby-lang.org/pub/ruby/3.2/ruby-3.2.0.tar.gz && \
    tar -xzf ruby-3.2.0.tar.gz && \
    cd ruby-3.2.0 && \
    ./configure --prefix=/usr/local/ruby-3.2 && \
    make && \
    make install && \
    cd .. && \
    rm -rf ruby-3.2.0 ruby-3.2.0.tar.gz
```

### Exemplo: Adicionar Go

```dockerfile
# ============================================================
# GO 1.21
# ============================================================
RUN cd /tmp && \
    wget https://go.dev/dl/go1.21.0.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.21.0.linux-amd64.tar.gz && \
    mv /usr/local/go /usr/local/go-1.21 && \
    rm go1.21.0.linux-amd64.tar.gz
```

---

## 📝 Passo 2: Adicionar em db/languages/active.rb

Abra `db/languages/active.rb` e adicione a configuração da linguagem.

### Estrutura Básica

```ruby
{
  id: XXX,                    # ID único (escolha um número não usado)
  name: "Nome da Linguagem",  # Nome descritivo
  is_archived: false,         # false para ativo
  source_file: "main.ext",    # Nome do arquivo fonte
  compile_cmd: "...",         # Comando de compilação (opcional)
  run_cmd: "..."              # Comando de execução (obrigatório)
}
```

### Exemplo: Ruby

```ruby
{
  id: 120,
  name: "Ruby (3.2.0)",
  is_archived: false,
  source_file: "script.rb",
  run_cmd: "/usr/local/ruby-3.2/bin/ruby script.rb"
}
```

### Exemplo: Go (com compilação)

```ruby
{
  id: 121,
  name: "Go (1.21)",
  is_archived: false,
  source_file: "main.go",
  compile_cmd: "GOCACHE=/tmp/.cache/go-build /usr/local/go-1.21/bin/go build %s main.go",
  run_cmd: "./main"
}
```

### Exemplo: PHP

```ruby
{
  id: 122,
  name: "PHP (8.2)",
  is_archived: false,
  source_file: "script.php",
  run_cmd: "/usr/local/php-8.2/bin/php script.php"
}
```

---

## 🎯 Passo 3: Escolher ID único

### IDs já usados:
- 100-118: Linguagens customizadas atuais
- 43-89: Linguagens do Judge0 original (ver `active.rb.backup`)

### Recomendação:
- Use IDs a partir de **120** para novas linguagens customizadas
- Mantenha uma lista de IDs usados

---

## 🐳 Passo 4: Rebuild e Deploy

### 1. Build da nova imagem

```bash
docker-compose -f docker-compose.custom.yml build --no-cache
```

### 2. Parar serviços

```bash
docker-compose -f docker-compose.custom.yml down
```

### 3. Iniciar serviços

```bash
docker-compose -f docker-compose.custom.yml up -d
```

### 4. Re-seed do banco de dados

```bash
# Aguarde os containers iniciarem
sleep 10

# Re-seed
docker-compose -f docker-compose.custom.yml exec server rails db:seed
```

---

## ✅ Passo 5: Testar

### 1. Verificar se a linguagem aparece

```bash
curl http://localhost:2358/languages | jq '.[] | select(.id == 120)'
```

Ou usando Python:
```bash
python examples/submit_example.py --list-languages | grep "Ruby"
```

### 2. Criar arquivo de teste

Crie `examples/test/hello.rb`:

```ruby
puts "Hello from Ruby!"
puts "Ruby version: #{RUBY_VERSION}"

# Array example
numbers = [1, 2, 3, 4, 5]
puts "Numbers: #{numbers.join(', ')}"

# Function example
def greet(name)
  "Hello, #{name}!"
end

puts greet("World")
```

### 3. Testar execução

```bash
python examples/submit_example.py examples/test/hello.rb 120 --wait
```

---

## 📦 Casos Especiais

### Linguagem Interpretada (sem compilação)

```ruby
{
  id: XXX,
  name: "Python (3.12)",
  is_archived: false,
  source_file: "script.py",
  run_cmd: "/usr/local/python-3.12/bin/python3 script.py"
}
```

### Linguagem Compilada

```ruby
{
  id: XXX,
  name: "Rust (1.75)",
  is_archived: false,
  source_file: "main.rs",
  compile_cmd: "/usr/local/rust-1.75/bin/rustc %s main.rs",
  run_cmd: "./main"
}
```

### Linguagem com Flags de Compilação

O `%s` será substituído pelas compiler_options do usuário:

```ruby
{
  id: XXX,
  name: "C++ (GCC 13)",
  is_archived: false,
  source_file: "main.cpp",
  compile_cmd: "/usr/bin/g++-13 %s main.cpp -o main",
  run_cmd: "./main"
}
```

### Linguagem Multi-file (Framework)

```ruby
{
  id: XXX,
  name: "React App",
  is_archived: false,
  # Sem source_file, sem run_cmd
  # O ZIP deve conter compile.sh e run.sh
}
```

---

## 🛠️ Variáveis Especiais

### No compile_cmd e run_cmd

- `%s` - Substituído pelas compiler_options fornecidas pelo usuário

### Variáveis de Ambiente

Você pode usar variáveis de ambiente nos comandos:

```ruby
run_cmd: "LD_LIBRARY_PATH=/usr/local/gcc-13/lib64 ./main"
run_cmd: "GOPATH=/tmp/go /usr/local/go-1.21/bin/go run main.go"
```

---

## 📋 Checklist

Antes de finalizar, verifique:

- [ ] Runtime/compilador instalado no Dockerfile
- [ ] ID único escolhido (não conflita com existentes)
- [ ] `source_file` correto
- [ ] `run_cmd` correto (caminho absoluto do executável)
- [ ] `compile_cmd` correto (se aplicável)
- [ ] Rebuild da imagem concluído
- [ ] Re-seed do banco executado
- [ ] Linguagem aparece em `/languages`
- [ ] Teste de execução bem-sucedido
- [ ] Exemplo adicionado em `examples/`

---

## 🔍 Troubleshooting

### Linguagem não aparece na lista

**Solução:**
```bash
# Re-seed
docker-compose -f docker-compose.custom.yml exec server rails db:seed

# Verificar no banco
docker-compose -f docker-compose.custom.yml exec server rails console
> Language.where(id: 120).first
```

### Erro "command not found" ao executar

**Problema:** Caminho do executável incorreto

**Solução:**
```bash
# Entre no container e verifique o caminho
docker-compose -f docker-compose.custom.yml exec server bash
which ruby
/usr/local/ruby-3.2/bin/ruby  # Use este caminho
```

### Erro de compilação

**Problema:** Sintaxe incorreta do `compile_cmd`

**Exemplo correto:**
```ruby
compile_cmd: "/usr/bin/gcc %s main.c -o main"
# %s é onde vão as compiler_options
```

### Timeout ao executar

**Solução:** Aumente os limites em `judge0.conf`:
```bash
MAX_CPU_TIME_LIMIT=30
MAX_WALL_TIME_LIMIT=60
```

---

## 💡 Dicas Avançadas

### 1. Usar versões específicas

Sempre especifique versões no nome:
```ruby
name: "Python (3.11.0)"  # ✅ Bom
name: "Python"           # ❌ Ruim
```

### 2. Testar dependências

Antes de adicionar, teste se o runtime funciona:
```bash
docker-compose -f docker-compose.custom.yml exec server bash
/usr/local/ruby-3.2/bin/ruby --version
```

### 3. Limpar cache do Go/Rust

Para linguagens com cache (Go, Rust), use paths temporários:
```ruby
compile_cmd: "GOCACHE=/tmp/.cache/go-build /usr/local/go/bin/go build main.go"
```

### 4. Adicionar bibliotecas extras

No Dockerfile, instale libs necessárias:
```dockerfile
RUN apt-get update && apt-get install -y \
    libssl-dev \
    libreadline-dev \
    zlib1g-dev
```

---

## 📚 Exemplos Completos

### Exemplo 1: Adicionar Kotlin

**Dockerfile.custom:**
```dockerfile
# ============================================================
# KOTLIN 1.9
# ============================================================
RUN cd /tmp && \
    wget https://github.com/JetBrains/kotlin/releases/download/v1.9.0/kotlin-compiler-1.9.0.zip && \
    unzip kotlin-compiler-1.9.0.zip && \
    mv kotlinc /usr/local/kotlin-1.9 && \
    rm kotlin-compiler-1.9.0.zip
```

**db/languages/active.rb:**
```ruby
{
  id: 120,
  name: "Kotlin (1.9.0)",
  is_archived: false,
  source_file: "Main.kt",
  compile_cmd: "/usr/local/kotlin-1.9/bin/kotlinc %s Main.kt -include-runtime -d Main.jar",
  run_cmd: "/usr/bin/java -jar Main.jar"
}
```

### Exemplo 2: Adicionar Perl

**Dockerfile.custom:**
```dockerfile
# Perl já vem instalado no Ubuntu, só precisamos do path
```

**db/languages/active.rb:**
```ruby
{
  id: 121,
  name: "Perl (5.34)",
  is_archived: false,
  source_file: "script.pl",
  run_cmd: "/usr/bin/perl script.pl"
}
```

---

## 🎓 Recursos Adicionais

- **Documentação Judge0 oficial:** https://github.com/judge0/judge0
- **Isolate sandbox:** https://github.com/ioi/isolate
- **Linguagens suportadas originalmente:** Ver `db/languages/active.rb.backup`

---

**Boa sorte adicionando novas linguagens! 🚀**
