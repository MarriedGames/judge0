# Exemplos de Testes para Judge0 Custom

Este diretório contém exemplos práticos de código para testar cada linguagem suportada.

## Estrutura
- `web/` - Exemplos de desenvolvimento web
- `game-engines/` - Exemplos de engines de jogos
- `general/` - Linguagens de propósito geral
- `devops/` - Exemplos de Docker e scripts

## Como usar

### Via cURL
```bash
# Codifique o arquivo em base64
base64 examples/web/hello.js

# Envie para a API
curl -X POST http://localhost:2358/submissions \
  -H "Content-Type: application/json" \
  -d '{
    "source_code": "BASE64_AQUI",
    "language_id": 101,
    "base64_encoded": true
  }'
```

### Via Script Python
```bash
python examples/submit_example.py examples/web/hello.js 101
```
