# 📚 Índice da Documentação - Judge0 Custom

**Guia completo de todos os arquivos de documentação e recursos do Judge0 Custom.**

---

## 🎯 Por Onde Começar?

### Se você é novo no projeto:
1. ✅ Leia [README_CUSTOM_MAIN.md](README_CUSTOM_MAIN.md) - Visão geral
2. ✅ Siga [QUICKSTART.md](QUICKSTART.md) - Deploy em 5 minutos
3. ✅ Teste os [examples/](examples/) - Exemplos práticos

### Se você quer customizar:
1. ✅ Leia [ADDING_LANGUAGES.md](ADDING_LANGUAGES.md) - Como adicionar linguagens
2. ✅ Consulte [judge0.conf.example](judge0.conf.example) - Configurações disponíveis
3. ✅ Veja [README.custom.md](README.custom.md) - Documentação completa da API

---

## 📖 Documentação Principal

### 🌟 README_CUSTOM_MAIN.md
**Visão geral do projeto customizado**

- O que é o Judge0 Custom
- Linguagens suportadas (tabela completa)
- Casos de uso
- Início rápido
- Comandos úteis
- Licença e créditos

**Quando usar:** Primeira leitura, visão geral do projeto

---

### 🚀 QUICKSTART.md
**Guia de início rápido (5 minutos)**

- Deploy automático com 1 comando
- Primeiros testes
- Linguagens disponíveis (tabela resumida)
- Comandos Docker úteis
- Troubleshooting básico
- Links para documentação detalhada

**Quando usar:** Para fazer deploy rápido e testar

---

### 📘 README.custom.md
**Documentação completa e detalhada**

- Introdução e features
- Instalação passo a passo
- Exemplos de uso da API (todos os endpoints)
- Exemplos de código para todas as 19 linguagens
- Configuração avançada
- Adicionar nova linguagem
- Testes
- Referência completa de IDs
- Codificação Base64
- Troubleshooting detalhado
- Próximos passos

**Quando usar:** Para referência completa da API e configuração avançada

---

### 🔧 ADDING_LANGUAGES.md
**Guia completo: Como adicionar novas linguagens**

- Passo a passo detalhado
- Modificar Dockerfile.custom
- Configurar db/languages/active.rb
- Escolher ID único
- Rebuild e deploy
- Testar
- Casos especiais (interpretada, compilada, multi-file)
- Variáveis especiais
- Checklist completo
- Troubleshooting
- Exemplos completos (Kotlin, Perl, etc.)

**Quando usar:** Quando quiser adicionar uma nova linguagem ao sistema

---

### 📊 IMPLEMENTATION_SUMMARY.md
**Resumo da implementação e customização**

- O que foi feito (checklist completo)
- Arquivos criados/modificados
- Tabela de todas as 19 linguagens
- Dependências instaladas no Docker
- Estrutura de diretórios
- Como usar (resumo)
- Configuração opcional (Unity, Unreal)
- Limites de recursos
- Segurança
- Testes incluídos
- Próximos passos
- Recursos especiais
- Destaques da implementação

**Quando usar:** Para entender o que foi customizado e o estado atual do projeto

---

### ⚙️ judge0.conf.example
**Arquivo de configuração exemplo**

- Configuração do Redis
- Configuração do PostgreSQL
- Versão e fila do Judge0
- Limites de recursos (CPU, memória, processos)
- Features habilitadas/desabilitadas
- Segurança
- Performance
- Modo de manutenção
- Telemetria
- Logging
- CORS
- Notas importantes

**Quando usar:** Para configurar o Judge0 (copie para `judge0.conf` e edite)

---

## 🐳 Arquivos de Infraestrutura

### Dockerfile.custom
**Imagem Docker customizada**

Instalação de:
- Node.js 18
- Python 3.11
- Lua 5.4
- Godot 4.2
- Mono 6.12 (Unity)
- .NET 7.0
- GCC 11 (Unreal)
- Docker & Docker Compose
- Scripts helpers (HTML runner, Blueprint interpreter, GML runner)

**Quando usar:** Para build da imagem Docker (automático via scripts)

---

### docker-compose.custom.yml
**Orquestração de serviços**

Serviços:
- `server` - API Judge0
- `workers` - Workers Resque
- `db` - PostgreSQL
- `redis` - Fila de jobs

Volumes:
- Linguagens customizadas
- Unity libs (opcional)
- Unreal headers (opcional)
- Dados PostgreSQL
- Dados Redis

**Quando usar:** Para iniciar/parar todos os serviços

---

## 🚀 Scripts de Deploy

### build-and-deploy.sh (Linux/Mac)
**Script automático de build e deploy**

Executa:
1. Criar diretórios necessários
2. Build da imagem Docker
3. Iniciar serviços
4. Aguardar database
5. Inicializar banco (create, migrate, seed)
6. Verificar status
7. Testar API

**Como usar:**
```bash
chmod +x build-and-deploy.sh && ./build-and-deploy.sh
```

---

### build-and-deploy.ps1 (Windows)
**Script automático de build e deploy (PowerShell)**

Mesmas funcionalidades do script Linux, adaptado para Windows.

**Como usar:**
```powershell
.\build-and-deploy.ps1
```

---

## 💻 Exemplos de Código

### examples/README.md
**Guia dos exemplos**

- Estrutura dos exemplos
- Como usar via cURL
- Como usar via script Python

---

### examples/submit_example.py
**Script Python para submeter exemplos**

Features:
- Auto-detecção de linguagem por extensão
- Codificação Base64 automática
- Polling de resultados
- Formatação bonita da saída
- Suporte para stdin
- Listar todas as linguagens

**Como usar:**
```bash
python examples/submit_example.py examples/web/hello.js --wait
python examples/submit_example.py --list-languages
```

---

### Exemplos por Categoria

**Web Development** (`examples/web/`)
- `hello.html` - HTML/CSS/JavaScript (ID: 100)
- `hello.js` - JavaScript Node.js (ID: 101)
- `hello.ts` - TypeScript (ID: 102)

**General Purpose** (`examples/general/`)
- `hello.py` - Python 3.11 (ID: 105)
- `hello.sh` - Bash (ID: 106)
- `hello.lua` - Lua 5.4 (ID: 107)
- `hello.sql` - SQL SQLite (ID: 108)

**Game Engines** (`examples/game-engines/`)
- `godot/hello.gd` - GDScript (ID: 109)
- `godot/hello.gdshader` - Godot Shader (ID: 110)
- `unity/hello.cs` - Unity C# (ID: 111)
- `unreal/hello.cpp` - Unreal C++ (ID: 113)
- `unreal/blueprint.json` - Blueprints (ID: 114)
- `gamemaker/hello.gml` - GML (ID: 115)

**DevOps** (`examples/devops/`)
- `Dockerfile.example` - Dockerfile (ID: 116)
- `docker-compose.example.yml` - Docker Compose (ID: 117)

---

## 🗂️ Configuração de Linguagens

### db/languages/active.rb
**19 linguagens customizadas**

Configuração de todas as linguagens com:
- ID único
- Nome e versão
- source_file
- compile_cmd (se aplicável)
- run_cmd

**Quando editar:** Ao adicionar/modificar linguagens

---

### db/languages/active.rb.backup
**Backup do arquivo original**

Contém as 47 linguagens originais do Judge0.

**Quando usar:** Para referência ou restaurar configuração original

---

## 📁 Diretórios Opcionais

### unity-libs/
**Bibliotecas Unity (opcional)**

Para usar Unity C# (ID: 111), adicione:
- `UnityEngine.dll`
- Outras DLLs necessárias

**Como usar:**
```bash
mkdir -p unity-libs
cp /path/to/UnityEngine.dll unity-libs/
docker-compose -f docker-compose.custom.yml restart
```

---

### unreal-headers/
**Headers Unreal Engine (opcional)**

Para usar Unreal C++ (ID: 113), adicione headers do Unreal.

**Como usar:**
```bash
mkdir -p unreal-headers
cp -r /path/to/UnrealEngine/Headers/* unreal-headers/
docker-compose -f docker-compose.custom.yml restart
```

---

## 🔍 Fluxo de Trabalho Recomendado

### 1️⃣ Primeiro Deploy
```
README_CUSTOM_MAIN.md (visão geral)
    ↓
QUICKSTART.md (deploy rápido)
    ↓
build-and-deploy.ps1 ou .sh (executar)
    ↓
examples/submit_example.py (testar)
```

### 2️⃣ Usar a API
```
README.custom.md (referência completa da API)
    ↓
judge0.conf.example (configurar limites)
    ↓
Integrar na sua aplicação
```

### 3️⃣ Adicionar Linguagem
```
ADDING_LANGUAGES.md (guia passo a passo)
    ↓
Dockerfile.custom (instalar runtime)
    ↓
db/languages/active.rb (configurar)
    ↓
build-and-deploy.ps1 ou .sh (rebuild)
```

### 4️⃣ Troubleshooting
```
QUICKSTART.md (troubleshooting básico)
    ↓
README.custom.md (troubleshooting detalhado)
    ↓
docker-compose logs (verificar logs)
```

---

## 📊 Tabela Rápida de Referência

| Arquivo | Propósito | Quando Usar |
|---------|-----------|-------------|
| README_CUSTOM_MAIN.md | Visão geral | Primeira leitura |
| QUICKSTART.md | Início rápido | Deploy rápido (5min) |
| README.custom.md | Documentação completa | Referência da API |
| ADDING_LANGUAGES.md | Adicionar linguagens | Customização |
| IMPLEMENTATION_SUMMARY.md | Resumo do projeto | Entender o que foi feito |
| INDEX.md | Este arquivo | Navegar documentação |
| judge0.conf.example | Configuração | Setup inicial |
| Dockerfile.custom | Imagem Docker | Build automático |
| docker-compose.custom.yml | Serviços | Iniciar/parar |
| build-and-deploy.sh/.ps1 | Deploy automático | Instalação |
| examples/ | Exemplos de código | Testes e aprendizado |
| db/languages/active.rb | Linguagens | Configuração |

---

## 🎯 FAQ - Perguntas Frequentes

### Como faço deploy?
→ Veja [QUICKSTART.md](QUICKSTART.md) ou execute `build-and-deploy.ps1`

### Como uso a API?
→ Veja [README.custom.md](README.custom.md) - Seção "Exemplos de Uso"

### Como adiciono uma nova linguagem?
→ Veja [ADDING_LANGUAGES.md](ADDING_LANGUAGES.md)

### Onde estão os exemplos?
→ Pasta `examples/` - Veja [examples/README.md](examples/README.md)

### Como configuro limites de recursos?
→ Edite `judge0.conf` - Veja [judge0.conf.example](judge0.conf.example)

### Como funciona o Unity/Unreal?
→ Veja [README.custom.md](README.custom.md) - Seção "Configuração Avançada"

### Qual ID usar para cada linguagem?
→ Veja [IMPLEMENTATION_SUMMARY.md](IMPLEMENTATION_SUMMARY.md) - Tabelas de IDs

---

## 🔗 Links Úteis

- **Judge0 Original:** https://github.com/judge0/judge0
- **Documentação API:** https://ce.judge0.com
- **Judge0 IDE:** https://ide.judge0.com
- **Isolate Sandbox:** https://github.com/ioi/isolate

---

## 📞 Suporte

Se você não encontrar o que procura:

1. ✅ Consulte este índice (INDEX.md)
2. ✅ Leia o troubleshooting em [QUICKSTART.md](QUICKSTART.md)
3. ✅ Veja exemplos práticos em [examples/](examples/)
4. ✅ Consulte documentação completa em [README.custom.md](README.custom.md)

---

<div align="center">

**📚 Índice da Documentação - Judge0 Custom**

*Desenvolvido com ❤️ para a comunidade de desenvolvimento de jogos e web*

</div>
