# 🎮 Judge0 Custom - Game Development & Web Development Edition

[![License](https://img.shields.io/github/license/judge0/judge0?color=2185d0&style=flat-square)](LICENSE)

**Versão customizada do Judge0 com suporte para desenvolvimento de jogos e web.**

---

## 🌟 O que é isto?

Esta é uma versão **customizada** do [Judge0](https://github.com/judge0/judge0) focada em:

- 🎮 **Desenvolvimento de Jogos** - Godot, Unity, Unreal Engine, GameMaker
- 🌐 **Desenvolvimento Web** - JavaScript, TypeScript, Vue, Nuxt
- 🛠️ **DevOps** - Docker, Docker Compose
- 🐍 **Linguagens Gerais** - Python, Lua, Bash, SQL

### ✨ Destaques

- ✅ **19 linguagens customizadas** focadas em game dev e web dev
- ✅ **Deploy automático** com scripts prontos (Windows/Linux/Mac)
- ✅ **15+ exemplos práticos** de código para todas as linguagens
- ✅ **Documentação completa** em português
- ✅ **Suporte multi-file** para projetos Vue e Nuxt

---

## 🚀 Início Rápido

### Pré-requisitos
- Docker e Docker Compose instalados
- Mínimo 4GB RAM
- 10GB espaço em disco

### Deploy em 1 Comando

**Windows (PowerShell):**
```powershell
.\build-and-deploy.ps1
```

**Linux/Mac:**
```bash
chmod +x build-and-deploy.sh && ./build-and-deploy.sh
```

### Testar

```bash
# Listar linguagens disponíveis
curl http://localhost:2358/languages

# Ou use Python
python examples/submit_example.py --list-languages

# Testar JavaScript
python examples/submit_example.py examples/web/hello.js --wait

# Testar GDScript (Godot)
python examples/submit_example.py examples/game-engines/godot/hello.gd --wait
```

---

## 📚 Documentação

### 🎯 Para Começar
- **[QUICKSTART.md](QUICKSTART.md)** - Guia de início rápido (5 minutos)
- **[README.custom.md](README.custom.md)** - Documentação completa com exemplos de API
- **[IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md)** - Resumo da implementação

### 🔧 Para Desenvolvedores
- **[ADDING_LANGUAGES.md](ADDING_LANGUAGES.md)** - Como adicionar novas linguagens
- **[judge0.conf.example](judge0.conf.example)** - Arquivo de configuração exemplo
- **[examples/](examples/)** - Exemplos de código para todas as linguagens

---

## 🌐 Linguagens Suportadas

### Desenvolvimento Web (5 linguagens)
| ID  | Linguagem | Versão |
|-----|-----------|--------|
| 100 | HTML/CSS/JavaScript | - |
| 101 | JavaScript | Node.js 18 |
| 102 | TypeScript | 5.0 |
| 103 | Vue 3 | Multi-file |
| 104 | Nuxt 3 | Multi-file |

### Linguagens Gerais (4 linguagens)
| ID  | Linguagem | Versão |
|-----|-----------|--------|
| 105 | Python | 3.11 |
| 106 | Bash | 5.2 |
| 107 | Lua | 5.4 |
| 108 | SQL | SQLite 3 |

### Game Engines (7 linguagens)
| ID  | Linguagem | Engine | Notas |
|-----|-----------|--------|-------|
| 109 | GDScript | Godot 4.2 | ✅ Pronto |
| 110 | Godot Shader Language | Godot 4.2 | ✅ Pronto |
| 111 | C# (Unity) | Mono 6.12 | Requer Unity DLLs* |
| 112 | C# (.NET) | .NET 7.0 | ✅ Pronto |
| 113 | C++ (Unreal) | GCC 11 | Requer Unreal headers* |
| 114 | Blueprints | Unreal | ✅ Pronto |
| 115 | GML | GameMaker | ✅ Pronto |

\* *Opcional - Veja instruções em [README.custom.md](README.custom.md)*

### DevOps (2 linguagens)
| ID  | Linguagem | Tipo |
|-----|-----------|------|
| 116 | Dockerfile | Validation |
| 117 | Docker Compose | Validation |

### Utilitário
| ID  | Linguagem | Uso |
|-----|-----------|-----|
| 118 | Multi-file program | Projetos complexos |

---

## 💻 Exemplos de Uso

### Via API (cURL)

```bash
# JavaScript
curl -X POST http://localhost:2358/submissions \
  -H "Content-Type: application/json" \
  -d '{
    "source_code": "Y29uc29sZS5sb2coIkhlbGxvLCBXb3JsZCEiKTs=",
    "language_id": 101,
    "base64_encoded": true,
    "wait": true
  }'
```

### Via Script Python

```bash
# Detecta a linguagem automaticamente pela extensão
python examples/submit_example.py examples/web/hello.js --wait
python examples/submit_example.py examples/general/hello.py --wait
python examples/submit_example.py examples/game-engines/godot/hello.gd --wait
```

### Via código Python

```python
import requests
import base64

code = "console.log('Hello, World!');"
encoded = base64.b64encode(code.encode()).decode()

response = requests.post('http://localhost:2358/submissions', json={
    "source_code": encoded,
    "language_id": 101,
    "base64_encoded": True,
    "wait": True
})

print(response.json()['stdout'])  # Hello, World!
```

---

## 🎯 Casos de Uso

### 1. Plataforma de Aprendizado de Programação
- Estudantes executam código diretamente no navegador
- Suporte para múltiplas linguagens (web + game dev)
- Feedback instantâneo com resultados detalhados

### 2. Sistema de Avaliação de Código
- Testes automatizados de soluções
- Limites de tempo e memória configuráveis
- Suporte para testes em lote

### 3. IDE Online para Game Development
- Teste rápido de scripts GDScript, GML, C#
- Validação de shaders
- Prototipagem rápida de lógica de jogo

### 4. Plataforma de Desafios de Código
- Competições de programação
- Ranking baseado em performance
- Suporte para callbacks (webhooks)

---

## ⚙️ Configuração

### Limites de Recursos (judge0.conf)

```bash
MAX_CPU_TIME_LIMIT=15              # Tempo máximo de CPU (segundos)
MAX_MEMORY_LIMIT=512000            # Memória máxima (KB)
MAX_PROCESSES_AND_OR_THREADS=60    # Processos máximos
MAX_QUEUE_SIZE=100                 # Tamanho da fila
```

### Features Habilitadas

```bash
ENABLE_WAIT_RESULT=true            # Execução síncrona
ENABLE_COMPILER_OPTIONS=true       # Opções customizadas
ENABLE_CALLBACKS=true              # Webhooks
ENABLE_ADDITIONAL_FILES=true       # Multi-file support
ENABLE_NETWORK=false               # Rede desabilitada (segurança)
```

---

## 📦 Arquivos do Projeto

```
judge0/
├── 📄 README.custom.md              # Documentação completa
├── 📄 QUICKSTART.md                 # Guia rápido
├── 📄 IMPLEMENTATION_SUMMARY.md     # Resumo da implementação
├── 📄 ADDING_LANGUAGES.md           # Como adicionar linguagens
├── 🐳 Dockerfile.custom             # Imagem Docker customizada
├── 🐳 docker-compose.custom.yml     # Orquestração de serviços
├── 🔧 judge0.conf.example           # Configuração exemplo
├── 🚀 build-and-deploy.sh           # Script deploy (Linux/Mac)
├── 🚀 build-and-deploy.ps1          # Script deploy (Windows)
├── 📁 db/languages/
│   ├── active.rb                    # 19 linguagens customizadas
│   └── active.rb.backup             # Backup original
├── 📁 examples/                     # 15+ exemplos práticos
│   ├── web/                         # HTML, JS, TS
│   ├── general/                     # Python, Bash, Lua, SQL
│   ├── game-engines/                # Godot, Unity, Unreal, GameMaker
│   ├── devops/                      # Docker, Docker Compose
│   └── submit_example.py            # Script de teste
├── 📁 unity-libs/                   # Unity DLLs (opcional)
└── 📁 unreal-headers/               # Unreal headers (opcional)
```

---

## 🔐 Segurança

- ✅ **Sandbox Isolate** - Execução isolada com cgroups do Linux
- ✅ **Limites de Recursos** - CPU, memória, processos, tempo
- ✅ **Rede Desabilitada** - Sem acesso à internet por padrão
- ✅ **Sanitização de Input** - Proteção contra shell injection
- ✅ **Base64 Encoding** - Segurança no transporte de dados

---

## 🛠️ Comandos Úteis

```bash
# Iniciar
docker-compose -f docker-compose.custom.yml up -d

# Parar
docker-compose -f docker-compose.custom.yml down

# Ver logs
docker-compose -f docker-compose.custom.yml logs -f server

# Resetar banco
docker-compose -f docker-compose.custom.yml exec server rails db:reset

# Entrar no container
docker-compose -f docker-compose.custom.yml exec server bash

# Rebuild
docker-compose -f docker-compose.custom.yml build --no-cache
```

---

## 🐛 Troubleshooting

### Problema comum 1: Container não inicia

```bash
# Verificar logs
docker-compose -f docker-compose.custom.yml logs server

# Verificar portas
netstat -an | grep 2358  # Linux/Mac
Get-NetTCPConnection -LocalPort 2358  # Windows
```

### Problema comum 2: Linguagem não aparece

```bash
# Re-seed do banco
docker-compose -f docker-compose.custom.yml exec server rails db:seed

# Listar linguagens no banco
curl http://localhost:2358/languages | jq
```

### Problema comum 3: Timeout na execução

Edite `judge0.conf` e aumente os limites:
```bash
MAX_CPU_TIME_LIMIT=30
MAX_WALL_TIME_LIMIT=60
```

**Mais troubleshooting:** Veja [README.custom.md](README.custom.md)

---

## 📖 Recursos Adicionais

### Documentação
- [Judge0 Oficial](https://github.com/judge0/judge0)
- [Documentação da API](https://ce.judge0.com)
- [Isolate Sandbox](https://github.com/ioi/isolate)

### Exemplos e Tutoriais
- [Judge0 IDE](https://ide.judge0.com) - IDE online oficial
- [Judge0 Paper](https://paper.judge0.com) - Pesquisa acadêmica

---

## 🤝 Contribuindo

Contribuições são bem-vindas! Para adicionar novas linguagens:

1. Leia [ADDING_LANGUAGES.md](ADDING_LANGUAGES.md)
2. Modifique `Dockerfile.custom` e `db/languages/active.rb`
3. Teste suas mudanças
4. Submeta um Pull Request

---

## 📄 Licença

Este projeto é baseado no [Judge0](https://github.com/judge0/judge0) original e mantém a mesma licença.

- **Judge0 Original:** [GNU General Public License v3.0](LICENSE)
- **Esta Customização:** Mesma licença (GPL v3.0)

---

## 🙏 Créditos

### Judge0 Original
- **Autor:** [Herman Zvonimir Došilović](https://github.com/hermanzdosilovic)
- **Projeto:** [github.com/judge0/judge0](https://github.com/judge0/judge0)

### Customização (Game Dev & Web Dev)
- **Customizado para:** Desenvolvimento de jogos e web
- **Linguagens adicionadas:** 19 (focadas em game engines e frameworks web)
- **Data:** Outubro 2025

---

## 📞 Suporte

- 📖 **Documentação:** [README.custom.md](README.custom.md)
- 🚀 **Início Rápido:** [QUICKSTART.md](QUICKSTART.md)
- 🔧 **Adicionar Linguagens:** [ADDING_LANGUAGES.md](ADDING_LANGUAGES.md)
- 📊 **Resumo:** [IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md)

---

## 🎯 Roadmap Futuro

- [ ] Suporte completo para Godot com renderização
- [ ] Interpretador GML completo
- [ ] Suporte para React e Angular
- [ ] UI web para facilitar testes
- [ ] Métricas e monitoramento com Prometheus
- [ ] CI/CD com GitHub Actions

---

<div align="center">

**Desenvolvido com ❤️ para a comunidade de desenvolvimento de jogos e web**

[Judge0 Original](https://github.com/judge0/judge0) • [Documentação](README.custom.md) • [Exemplos](examples/)

</div>
