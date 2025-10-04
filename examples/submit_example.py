#!/usr/bin/env python3
"""
Script para enviar exemplos de código para o Judge0 Custom
Usage: python submit_example.py <file_path> <language_id> [--wait]
"""

import sys
import base64
import json
import requests
import time
from pathlib import Path

# Judge0 API endpoint
API_URL = "http://localhost:2358"

# Mapeamento de extensões para IDs de linguagem
LANGUAGE_MAP = {
    '.html': 100,
    '.js': 101,
    '.ts': 102,
    '.py': 105,
    '.sh': 106,
    '.lua': 107,
    '.sql': 108,
    '.gd': 109,
    '.gdshader': 110,
    '.cs': 111,  # Unity C#
    '.cpp': 113,
    '.json': 114,  # Blueprints
    '.gml': 115,
    'Dockerfile': 116,
    '.yml': 117,
    '.yaml': 117,
}

def encode_file(file_path):
    """Lê o arquivo e retorna o conteúdo em base64"""
    with open(file_path, 'rb') as f:
        content = f.read()
    return base64.b64encode(content).decode('utf-8')

def detect_language(file_path):
    """Detecta o language_id baseado na extensão do arquivo"""
    path = Path(file_path)
    
    # Caso especial para Dockerfile
    if path.name == 'Dockerfile' or path.name.startswith('Dockerfile.'):
        return 116
    
    # Extensão normal
    ext = path.suffix.lower()
    return LANGUAGE_MAP.get(ext)

def submit_code(file_path, language_id=None, wait=False, stdin=None):
    """
    Envia código para o Judge0 API
    
    Args:
        file_path: Caminho do arquivo com código
        language_id: ID da linguagem (None para auto-detectar)
        wait: Se True, aguarda o resultado
        stdin: Entrada padrão (opcional)
    """
    # Auto-detectar linguagem se não fornecido
    if language_id is None:
        language_id = detect_language(file_path)
        if language_id is None:
            print(f"❌ Erro: Não foi possível detectar a linguagem do arquivo {file_path}")
            print(f"   Extensões suportadas: {', '.join(LANGUAGE_MAP.keys())}")
            return None
    
    print(f"📝 Lendo arquivo: {file_path}")
    print(f"🔢 Language ID: {language_id}")
    
    # Codificar arquivo
    try:
        source_code = encode_file(file_path)
    except FileNotFoundError:
        print(f"❌ Erro: Arquivo não encontrado: {file_path}")
        return None
    except Exception as e:
        print(f"❌ Erro ao ler arquivo: {e}")
        return None
    
    # Preparar payload
    payload = {
        "source_code": source_code,
        "language_id": language_id,
        "base64_encoded": True,
    }
    
    if stdin:
        payload["stdin"] = base64.b64encode(stdin.encode()).decode()
    
    if wait:
        payload["wait"] = True
    
    # Enviar para API
    print(f"🚀 Enviando para {API_URL}/submissions...")
    
    try:
        response = requests.post(
            f"{API_URL}/submissions",
            json=payload,
            headers={"Content-Type": "application/json"}
        )
        response.raise_for_status()
    except requests.exceptions.RequestException as e:
        print(f"❌ Erro ao conectar com a API: {e}")
        print(f"   Certifique-se de que o Judge0 está rodando em {API_URL}")
        return None
    
    result = response.json()
    token = result.get('token')
    
    if not token:
        print(f"❌ Erro: Resposta inválida da API")
        print(json.dumps(result, indent=2))
        return None
    
    print(f"✅ Submissão criada! Token: {token}")
    
    # Se wait=True, resultado já está disponível
    if wait and 'status' in result:
        print_result(result)
        return result
    
    # Caso contrário, fazer polling
    print(f"⏳ Aguardando resultado...")
    return get_result(token)

def get_result(token, max_attempts=30, interval=1):
    """Busca o resultado de uma submissão"""
    for attempt in range(max_attempts):
        try:
            response = requests.get(
                f"{API_URL}/submissions/{token}",
                params={"base64_encoded": "false"}
            )
            response.raise_for_status()
            result = response.json()
            
            status_id = result.get('status', {}).get('id')
            
            # 1 = In Queue, 2 = Processing
            if status_id in [1, 2]:
                print(f"⏳ Status: {result['status']['description']}...", end='\r')
                time.sleep(interval)
                continue
            
            # Resultado pronto
            print_result(result)
            return result
            
        except requests.exceptions.RequestException as e:
            print(f"❌ Erro ao buscar resultado: {e}")
            return None
    
    print(f"⏰ Timeout: Resultado não disponível após {max_attempts} tentativas")
    return None

def print_result(result):
    """Imprime o resultado formatado"""
    print("\n" + "="*60)
    print("📊 RESULTADO DA EXECUÇÃO")
    print("="*60)
    
    status = result.get('status', {})
    print(f"\n🏷️  Status: {status.get('description', 'Unknown')}")
    
    # Tempo e memória
    if result.get('time'):
        print(f"⏱️  Tempo: {result['time']}s")
    if result.get('memory'):
        print(f"💾 Memória: {result['memory']} KB")
    
    # Saída
    stdout = result.get('stdout')
    if stdout:
        print(f"\n📤 Saída (stdout):")
        print("-" * 60)
        print(stdout)
        print("-" * 60)
    
    # Erros de compilação
    compile_output = result.get('compile_output')
    if compile_output:
        print(f"\n🔨 Saída da Compilação:")
        print("-" * 60)
        print(compile_output)
        print("-" * 60)
    
    # Erros de execução
    stderr = result.get('stderr')
    if stderr:
        print(f"\n❌ Erros (stderr):")
        print("-" * 60)
        print(stderr)
        print("-" * 60)
    
    print("="*60 + "\n")

def list_languages():
    """Lista todas as linguagens disponíveis"""
    try:
        response = requests.get(f"{API_URL}/languages")
        response.raise_for_status()
        languages = response.json()
        
        print("\n🌐 LINGUAGENS DISPONÍVEIS")
        print("="*60)
        for lang in languages:
            print(f"ID {lang['id']:3d} - {lang['name']}")
        print("="*60 + "\n")
        
    except requests.exceptions.RequestException as e:
        print(f"❌ Erro ao listar linguagens: {e}")

def main():
    if len(sys.argv) < 2:
        print("Usage: python submit_example.py <file_path> [language_id] [--wait] [--stdin <input>]")
        print("\nExemplos:")
        print("  python submit_example.py examples/web/hello.js")
        print("  python submit_example.py examples/general/hello.py 105 --wait")
        print("  python submit_example.py examples/web/hello.js 101 --stdin 'Input data'")
        print("\nComandos especiais:")
        print("  python submit_example.py --list-languages  # Lista todas as linguagens")
        sys.exit(1)
    
    # Comando especial: listar linguagens
    if sys.argv[1] == '--list-languages':
        list_languages()
        sys.exit(0)
    
    file_path = sys.argv[1]
    language_id = None
    wait = False
    stdin = None
    
    # Parse argumentos
    i = 2
    while i < len(sys.argv):
        arg = sys.argv[i]
        
        if arg == '--wait':
            wait = True
            i += 1
        elif arg == '--stdin':
            if i + 1 < len(sys.argv):
                stdin = sys.argv[i + 1]
                i += 2
            else:
                print("❌ Erro: --stdin requer um valor")
                sys.exit(1)
        elif arg.isdigit():
            language_id = int(arg)
            i += 1
        else:
            print(f"❌ Argumento desconhecido: {arg}")
            sys.exit(1)
    
    # Enviar código
    submit_code(file_path, language_id, wait, stdin)

if __name__ == "__main__":
    main()
