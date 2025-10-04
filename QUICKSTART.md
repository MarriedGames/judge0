# 🚀 Guia Rápido de Início - Judge0 Custom

## ⚡ Início Rápido (5 minutos)

### 1. Build e Deploy Automático

**Windows (PowerShell):**
```powershell
.\build-and-deploy.ps1
```

**Linux/Mac:**
```bash
chmod +x build-and-deploy.sh
./build-and-deploy.sh
```

### 2. Testar a API

```bash
# Listar linguagens disponíveis
curl http://localhost:2358/languages

# Ou use Python
python examples/submit_example.py --list-languages
```

### 3. Executar seu primeiro código

**Exemplo JavaScript:**
```bash
python examples/submit_example.py examples/web/hello.js --wait
```

**Exemplo Python:**
```bash
python examples/submit_example.py examples/general/hello.py --wait
```

**Exemplo GDScript (Godot):**
```bash
python examples/submit_example.py examples/game-engines/godot/hello.gd --wait
```

---

## 📋 Linguagens Disponíveis (IDs)

| ID  | Linguagem | Arquivo de Exemplo |
|-----|-----------|-------------------|
| 100 | HTML/CSS/JavaScript | `examples/web/hello.html` |
| 101 | JavaScript (Node.js) | `examples/web/hello.js` |
| 102 | TypeScript | `examples/web/hello.ts` |
| 105 | Python 3.11 | `examples/general/hello.py` |
| 106 | Bash | `examples/general/hello.sh` |
| 107 | Lua | `examples/general/hello.lua` |
| 108 | SQL (SQLite) | `examples/general/hello.sql` |
| 109 | GDScript (Godot) | `examples/game-engines/godot/hello.gd` |
| 110 | Godot Shader | `examples/game-engines/godot/hello.gdshader` |
| 111 | C# (Unity) | `examples/game-engines/unity/hello.cs` |
| 113 | C++ (Unreal) | `examples/game-engines/unreal/hello.cpp` |
| 114 | Blueprints | `examples/game-engines/unreal/blueprint.json` |
| 115 | GML (GameMaker) | `examples/game-engines/gamemaker/hello.gml` |

---

## 🔧 Comandos Úteis

### Docker Compose

```bash
# Iniciar serviços
docker-compose -f docker-compose.custom.yml up -d

# Parar serviços
docker-compose -f docker-compose.custom.yml down

# Ver logs
docker-compose -f docker-compose.custom.yml logs -f server

# Reiniciar
docker-compose -f docker-compose.custom.yml restart

# Rebuild
docker-compose -f docker-compose.custom.yml build --no-cache
```

### Banco de Dados

```bash
# Resetar banco
docker-compose -f docker-compose.custom.yml exec server rails db:reset

# Rodar migrations
docker-compose -f docker-compose.custom.yml exec server rails db:migrate

# Seed (popular linguagens)
docker-compose -f docker-compose.custom.yml exec server rails db:seed
```

### Debug

```bash
# Entrar no container
docker-compose -f docker-compose.custom.yml exec server bash

# Ver status dos workers
docker-compose -f docker-compose.custom.yml exec workers ps aux

# Verificar Redis
docker-compose -f docker-compose.custom.yml exec redis redis-cli ping
```

---

## 💡 Exemplos de Uso da API

### 1. Enviar Código (JavaScript)

```bash
curl -X POST http://localhost:2358/submissions \
  -H "Content-Type: application/json" \
  -d '{
    "source_code": "Y29uc29sZS5sb2coIkhlbGxvLCBXb3JsZCEiKTs=",
    "language_id": 101,
    "base64_encoded": true
  }'
```

**Resposta:**
```json
{
  "token": "abc123-def456-ghi789"
}
```

### 2. Buscar Resultado

```bash
curl http://localhost:2358/submissions/abc123-def456-ghi789?base64_encoded=false
```

**Resposta:**
```json
{
  "status": {
    "id": 3,
    "description": "Accepted"
  },
  "stdout": "Hello, World!\n",
  "time": "0.023",
  "memory": 3456
}
```

### 3. Submissão Síncrona (com wait=true)

```bash
curl -X POST http://localhost:2358/submissions \
  -H "Content-Type: application/json" \
  -d '{
    "source_code": "cHJpbnQoIkhlbGxvIGZyb20gUHl0aG9uISIp",
    "language_id": 105,
    "base64_encoded": true,
    "wait": true
  }'
```

---

## 🛠️ Configuração Avançada

### Adicionar Unity DLLs (Opcional)

```bash
# 1. Criar diretório
mkdir -p unity-libs

# 2. Copiar DLLs do Unity
cp /path/to/Unity/Editor/Data/Managed/UnityEngine.dll unity-libs/

# 3. Reiniciar container
docker-compose -f docker-compose.custom.yml restart
```

### Adicionar Headers do Unreal (Opcional)

```bash
# 1. Criar diretório
mkdir -p unreal-headers

# 2. Copiar headers do Unreal
cp -r /path/to/UnrealEngine/Engine/Source/Runtime/Core/Public/* unreal-headers/

# 3. Reiniciar container
docker-compose -f docker-compose.custom.yml restart
```

### Ajustar Limites de Recursos

Edite `judge0.conf`:

```bash
# Tempo máximo de CPU (segundos)
MAX_CPU_TIME_LIMIT=15

# Memória máxima (KB)
MAX_MEMORY_LIMIT=512000

# Processos máximos
MAX_PROCESSES_AND_OR_THREADS=60

# Tamanho da fila
MAX_QUEUE_SIZE=100
```

Depois reinicie:
```bash
docker-compose -f docker-compose.custom.yml restart
```

---

## 🐛 Troubleshooting

### Problema: Container não inicia

**Solução:**
```bash
# Ver logs
docker-compose -f docker-compose.custom.yml logs server

# Verificar se as portas estão livres
netstat -an | grep 2358  # Linux/Mac
Get-NetTCPConnection -LocalPort 2358  # Windows PowerShell
```

### Problema: Linguagem não aparece

**Solução:**
```bash
# Re-seed do banco
docker-compose -f docker-compose.custom.yml exec server rails db:seed

# Verificar linguagens no banco
docker-compose -f docker-compose.custom.yml exec server rails console
> Language.all.count
> Language.all.pluck(:id, :name)
```

### Problema: Timeout na execução

**Solução:**
Aumente os limites em `judge0.conf`:
```bash
MAX_CPU_TIME_LIMIT=30
MAX_WALL_TIME_LIMIT=60
```

### Problema: Erro "Language does not exist"

**Solução:**
Verifique se está usando o `language_id` correto:
```bash
curl http://localhost:2358/languages | jq
```

---

## 📚 Próximos Passos

1. ✅ Explore os exemplos em `examples/`
2. ✅ Teste diferentes linguagens
3. ✅ Leia a documentação completa em `README.custom.md`
4. ✅ Customize os limites de recursos conforme necessário
5. ✅ Adicione suas próprias linguagens em `db/languages/active.rb`

---

## 🔗 Links Úteis

- **Documentação Completa:** `README.custom.md`
- **Exemplos de Código:** `examples/`
- **Linguagens Customizadas:** `db/languages/active.rb`
- **Docker Compose:** `docker-compose.custom.yml`
- **Dockerfile:** `Dockerfile.custom`

---

## 📞 Suporte

Se encontrar problemas:

1. Verifique os logs: `docker-compose -f docker-compose.custom.yml logs -f`
2. Consulte `README.custom.md` para troubleshooting detalhado
3. Abra uma issue no GitHub (se aplicável)

---

**Desenvolvido com ❤️ para desenvolvimento de jogos e web**
