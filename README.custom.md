# Judge0 Custom - Game Development & Web Development Edition

Este é um Judge0 customizado com suporte para linguagens de desenvolvimento de jogos e web.

## 📋 Linguagens Suportadas

### 🌐 Desenvolvimento Web
- **HTML/CSS/JavaScript** (ID: 100) - Execução combinada de HTML, CSS e JS
- **JavaScript** (ID: 101) - Node.js 18
- **TypeScript** (ID: 102) - TypeScript 5.0 com compilação automática
- **Vue 3** (ID: 103) - Projetos Vue 3 (multi-file)
- **Nuxt 3** (ID: 104) - Projetos Nuxt 3 (multi-file)

### 🐍 Linguagens Gerais
- **Python** (ID: 105) - Python 3.11
- **Bash** (ID: 106) - Bash Shell 5.2
- **Lua** (ID: 107) - Lua 5.4
- **SQL** (ID: 108) - SQLite 3

### 🎮 Godot Engine
- **GDScript** (ID: 109) - Godot 4.2 headless
- **Godot Shader Language** (ID: 110) - GLSL/GDSL shaders

### 🎯 Unity Engine
- **C# (Unity)** (ID: 111) - Mono 6.12 com UnityEngine.dll
- **C# (.NET)** (ID: 112) - .NET 7.0 moderno

### 🔷 Unreal Engine
- **C++ (Unreal)** (ID: 113) - GCC 11 com headers do Unreal
- **Blueprints** (ID: 114) - Visual scripts em JSON

### 🎲 Outras Engines
- **GML** (ID: 115) - GameMaker Language

### 🐳 DevOps
- **Dockerfile** (ID: 116) - Validação de Dockerfile
- **Docker Compose** (ID: 117) - Validação de docker-compose.yml

### 📦 Multi-file
- **Multi-file program** (ID: 118) - Suporte para projetos complexos

---

## 🚀 Instalação e Configuração

### Pré-requisitos
- Docker e Docker Compose instalados
- Mínimo 4GB RAM
- 10GB de espaço em disco

### Passo 1: Clone o Repositório
```bash
git clone https://github.com/your-repo/judge0.git
cd judge0
```

### Passo 2: Configurar Arquivos Adicionais (Opcional)

#### Para Unity (C#)
Crie o diretório `unity-libs/` e adicione os arquivos DLL do Unity:
```bash
mkdir -p unity-libs
# Copie UnityEngine.dll para unity-libs/
cp /path/to/UnityEngine.dll unity-libs/
```

#### Para Unreal Engine (C++)
Crie o diretório `unreal-headers/` e adicione os headers:
```bash
mkdir -p unreal-headers
# Copie headers do Unreal para unreal-headers/
```

### Passo 3: Build da Imagem Custom
```bash
docker-compose -f docker-compose.custom.yml build
```

### Passo 4: Iniciar os Serviços
```bash
docker-compose -f docker-compose.custom.yml up -d
```

### Passo 5: Verificar Status
```bash
docker-compose -f docker-compose.custom.yml ps
docker-compose -f docker-compose.custom.yml logs -f server
```

### Passo 6: Inicializar o Banco de Dados
```bash
docker-compose -f docker-compose.custom.yml exec server rails db:create db:migrate db:seed
```

---

## 📚 Exemplos de Uso

### API Endpoint
```
POST http://localhost:2358/submissions
GET  http://localhost:2358/submissions/:token
GET  http://localhost:2358/languages
```

### Exemplo 1: JavaScript (Node.js)
```bash
curl -X POST http://localhost:2358/submissions \
  -H "Content-Type: application/json" \
  -d '{
    "source_code": "Y29uc29sZS5sb2coIkhlbGxvLCBXb3JsZCEiKTs=",
    "language_id": 101,
    "base64_encoded": true
  }'
```

**source_code** (decodificado):
```javascript
console.log("Hello, World!");
```

### Exemplo 2: Python 3.11
```bash
curl -X POST http://localhost:2358/submissions \
  -H "Content-Type: application/json" \
  -d '{
    "source_code": "cHJpbnQoIkhlbGxvLCBQeXRob24hIik=",
    "language_id": 105,
    "base64_encoded": true
  }'
```

**source_code** (decodificado):
```python
print("Hello, Python!")
```

### Exemplo 3: TypeScript
```bash
curl -X POST http://localhost:2358/submissions \
  -H "Content-Type: application/json" \
  -d '{
    "source_code": "Y29uc3QgbWVzc2FnZTogc3RyaW5nID0gIkhlbGxvLCBUeXBlU2NyaXB0ISI7CmNvbnNvbGUubG9nKG1lc3NhZ2UpOw==",
    "language_id": 102,
    "base64_encoded": true
  }'
```

**source_code** (decodificado):
```typescript
const message: string = "Hello, TypeScript!";
console.log(message);
```

### Exemplo 4: GDScript (Godot)
```bash
curl -X POST http://localhost:2358/submissions \
  -H "Content-Type: application/json" \
  -d '{
    "source_code": "ZXh0ZW5kcyBOb2RlCgpmdW5jIF9yZWFkeSgpOgoJcHJpbnQoIkhlbGxvIGZyb20gR29kb3QhIik=",
    "language_id": 109,
    "base64_encoded": true
  }'
```

**source_code** (decodificado):
```gdscript
extends Node

func _ready():
	print("Hello from Godot!")
```

### Exemplo 5: C# (Unity)
```bash
curl -X POST http://localhost:2358/submissions \
  -H "Content-Type: application/json" \
  -d '{
    "source_code": "dXNpbmcgU3lzdGVtOwoKcHVibGljIGNsYXNzIEhlbGxvV29ybGQKewogICAgcHVibGljIHN0YXRpYyB2b2lkIE1haW4oKQogICAgewogICAgICAgIENvbnNvbGUuV3JpdGVMaW5lKCJIZWxsbywgVW5pdHkhIik7CiAgICB9Cn0=",
    "language_id": 111,
    "base64_encoded": true
  }'
```

**source_code** (decodificado):
```csharp
using System;

public class HelloWorld
{
    public static void Main()
    {
        Console.WriteLine("Hello, Unity!");
    }
}
```

### Exemplo 6: SQL (SQLite)
```bash
curl -X POST http://localhost:2358/submissions \
  -H "Content-Type: application/json" \
  -d '{
    "source_code": "Q1JFQVRFIFRBQkxFIHVzZXJzIChpZCBJTlRFR0VSLCB1c2VybmFtZSBURVhUKTsKSU5TRVJUIElOVE8gdXNlcnMgVkFMVUVTICgxLCAiYWRtaW4iKTsKU0VMRUNUICogRlJPTSB1c2Vyczs=",
    "language_id": 108,
    "base64_encoded": true
  }'
```

**source_code** (decodificado):
```sql
CREATE TABLE users (id INTEGER, username TEXT);
INSERT INTO users VALUES (1, "admin");
SELECT * FROM users;
```

### Exemplo 7: HTML/CSS/JavaScript
```bash
curl -X POST http://localhost:2358/submissions \
  -H "Content-Type: application/json" \
  -d '{
    "source_code": "PCFET0NUWVBFIGh0bWw+CjxodG1sPgo8aGVhZD4KICAgIDx0aXRsZT5UZXN0ZTwvdGl0bGU+CjwvaGVhZD4KPGJvZHk+CiAgICA8c2NyaXB0PgogICAgICAgIGNvbnNvbGUubG9nKCJIZWxsbywgSFRNTCEiKTsKICAgIDwvc2NyaXB0Pgo8L2JvZHk+CjwvaHRtbD4=",
    "language_id": 100,
    "base64_encoded": true
  }'
```

**source_code** (decodificado):
```html
<!DOCTYPE html>
<html>
<head>
    <title>Teste</title>
</head>
<body>
    <script>
        console.log("Hello, HTML!");
    </script>
</body>
</html>
```

### Exemplo 8: Projeto Multi-file (Vue/Nuxt)
```bash
# Primeiro, crie um arquivo ZIP com a estrutura do projeto
# O ZIP deve conter compile.sh e run.sh

curl -X POST http://localhost:2358/submissions \
  -H "Content-Type: application/json" \
  -d '{
    "additional_files": "UEsDBBQAAAAIAF...(base64 do ZIP)...",
    "language_id": 103,
    "base64_encoded": true
  }'
```

**Estrutura do ZIP para Vue:**
```
project.zip
├── compile.sh      # npm install && npm run build
├── run.sh          # npm run preview
├── package.json
├── src/
│   └── App.vue
└── index.html
```

---

## 🔧 Configuração Avançada

### Variáveis de Ambiente (judge0.conf)

Edite `judge0.conf` para personalizar:

```bash
# Limites de recursos
MAX_CPU_TIME_LIMIT=15
MAX_MEMORY_LIMIT=512000
MAX_PROCESSES_AND_OR_THREADS=60

# Features
ENABLE_WAIT_RESULT=true
ENABLE_COMPILER_OPTIONS=true
ENABLE_CALLBACKS=true
ENABLE_ADDITIONAL_FILES=true

# Tamanho da fila
MAX_QUEUE_SIZE=100

# Cache
SUBMISSION_CACHE_DURATION=1
```

### Adicionar Nova Linguagem

1. Edite `db/languages/active.rb`:
```ruby
{
  id: 119,
  name: "Minha Linguagem",
  is_archived: false,
  source_file: "script.ext",
  compile_cmd: "/path/to/compiler %s script.ext",  # Opcional
  run_cmd: "/path/to/runtime script.ext"
}
```

2. Atualize o Dockerfile.custom para instalar a linguagem

3. Rebuild:
```bash
docker-compose -f docker-compose.custom.yml down
docker-compose -f docker-compose.custom.yml build
docker-compose -f docker-compose.custom.yml up -d
docker-compose -f docker-compose.custom.yml exec server rails db:seed
```

---

## 🧪 Testes

### Testar todas as linguagens
```bash
# HTML/CSS/JS
curl -X POST http://localhost:2358/submissions \
  -H "Content-Type: application/json" \
  -d '{"source_code":"PHNjcmlwdD5jb25zb2xlLmxvZygiSGVsbG8hIik8L3NjcmlwdD4=","language_id":100,"base64_encoded":true}'

# JavaScript
curl -X POST http://localhost:2358/submissions \
  -H "Content-Type: application/json" \
  -d '{"source_code":"Y29uc29sZS5sb2coIkhlbGxvISIp","language_id":101,"base64_encoded":true}'

# Python
curl -X POST http://localhost:2358/submissions \
  -H "Content-Type: application/json" \
  -d '{"source_code":"cHJpbnQoIkhlbGxvISIp","language_id":105,"base64_encoded":true}'
```

### Listar todas as linguagens disponíveis
```bash
curl http://localhost:2358/languages
```

---

## 📖 Referências

### IDs de Linguagens
| ID  | Linguagem | Tipo |
|-----|-----------|------|
| 100 | HTML/CSS/JavaScript | Web |
| 101 | JavaScript (Node.js 18) | Web |
| 102 | TypeScript (5.0) | Web |
| 103 | Vue 3 | Framework |
| 104 | Nuxt 3 | Framework |
| 105 | Python (3.11) | General |
| 106 | Bash (5.2) | Shell |
| 107 | Lua (5.4) | Scripting |
| 108 | SQL (SQLite 3) | Database |
| 109 | GDScript (Godot 4.2) | Game Engine |
| 110 | Godot Shader Language | Game Engine |
| 111 | C# (Unity - Mono 6.12) | Game Engine |
| 112 | C# (.NET 7.0) | General |
| 113 | C++ (Unreal - GCC 11) | Game Engine |
| 114 | Blueprints (JSON) | Game Engine |
| 115 | GML (GameMaker) | Game Engine |
| 116 | Dockerfile | DevOps |
| 117 | Docker Compose | DevOps |
| 118 | Multi-file program | Multi-file |

### Codificação Base64

Para codificar código em Base64:

**Linux/Mac:**
```bash
echo -n 'console.log("Hello!");' | base64
```

**PowerShell:**
```powershell
[Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes('console.log("Hello!");'))
```

**Python:**
```python
import base64
code = 'console.log("Hello!");'
encoded = base64.b64encode(code.encode()).decode()
print(encoded)
```

---

## 🐛 Troubleshooting

### Container não inicia
```bash
# Ver logs
docker-compose -f docker-compose.custom.yml logs server
docker-compose -f docker-compose.custom.yml logs workers

# Reiniciar
docker-compose -f docker-compose.custom.yml restart
```

### Banco de dados não foi criado
```bash
docker-compose -f docker-compose.custom.yml exec server rails db:create db:migrate db:seed
```

### Linguagem não aparece na lista
```bash
# Re-seed do banco
docker-compose -f docker-compose.custom.yml exec server rails db:seed

# Verificar se a linguagem está no arquivo active.rb
docker-compose -f docker-compose.custom.yml exec server cat /usr/local/judge0/db/languages/active.rb
```

### Erro "Language does not exist"
Certifique-se de usar o `language_id` correto da tabela acima.

### Timeout na execução
Aumente os limites em `judge0.conf`:
```bash
MAX_CPU_TIME_LIMIT=30
MAX_WALL_TIME_LIMIT=60
```

---

## 📞 Suporte

- **Documentação oficial Judge0:** https://github.com/judge0/judge0
- **Issue do GitHub:** [Link para criar issue no repo]

---

## 📄 Licença

Este projeto é baseado no [Judge0](https://github.com/judge0/judge0) e mantém a mesma licença.

---

## 🎯 Próximos Passos

- [ ] Adicionar suporte completo para Godot (com renderização headless)
- [ ] Implementar interpretador GML completo
- [ ] Adicionar suporte para React e Angular
- [ ] Criar UI web para facilitar testes
- [ ] Adicionar métricas e monitoramento

---

**Desenvolvido com ❤️ para a comunidade de desenvolvimento de jogos e web**
