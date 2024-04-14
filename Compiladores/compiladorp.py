#!/bin/python3

import os
import http.server
import socketserver
import threading
import webbrowser

def executar_html(nome_arquivo, caminho_arquivo):
    nome_c_arquivo = f"{nome_arquivo}.html"
    caminho_completo = os.path.join(caminho_arquivo, nome_c_arquivo)

    if not os.path.exists(caminho_completo):
        print("O arquivo especificado não existe.")
        return

    if nome_c_arquivo.endswith(".html"):
        porta = 8000  # Porta para o servidor HTTP
        os.chdir(caminho_arquivo)

        # Definindo o handler do servidor HTTP
        class Handler(http.server.SimpleHTTPRequestHandler):
            def __init__(self, *args, **kwargs):
                super().__init__(*args, directory=caminho_arquivo, **kwargs)

        # Iniciando o servidor HTTP em uma thread
        with socketserver.TCPServer(("", porta), Handler) as httpd:
            print(f"Servidor HTTP iniciado em http://localhost:{porta}")
            threading.Thread(target=httpd.serve_forever, daemon=True).start()

        # Abrindo o navegador padrão
        url = f"http://localhost:{porta}/{nome_c_arquivo}"
        print(f"Abrindo {url} no navegador padrão...")
        webbrowser.open(url)
    elif nome_c_arquivo.endswith(".css"):
        print("Visualização de arquivos CSS não é suportada neste modo.")
    else:
        print("Apenas arquivos HTML podem ser executados desta forma.")

def executar_arquivo(nome_arquivo, extensao, caminho_arquivo):
    nome_c_arquivo = f"{nome_arquivo}.{extensao}"
    caminho_completo = os.path.join(caminho_arquivo, nome_c_arquivo)

    if not os.path.exists(caminho_completo):
        print("O arquivo especificado não existe.")
        return

    if extensao in ["html", "css"]:
        executar_html(nome_arquivo, caminho_arquivo)
        return

    compiladores = {
        "py": "python3",
        "rb": "ruby",
        "cpp": "g++",
        "c": "gcc",
        "cs": "mcs",
        "java": "java",
        "js": "node",
        "php": "php",
        "pl": "perl",
        "lua": "lua",
        "swift": "swiftc",
        "r": "Rscript",
        "go": "go run",
        "scala": "scala",
        "pas": "fpc",
        "rs": "rustc",
    }

    compilador = compiladores.get(extensao)
    if compilador:
        if extensao in ["c", "cpp", "cs"]:
            comando = f"{compilador} -o {nome_arquivo} {nome_c_arquivo} && ./{nome_arquivo}"
        else:
            comando = f"{compilador} {nome_c_arquivo}"
        
        comando_final = f"cd {caminho_arquivo} && {comando}"
        print(f"Executando: {comando_final}")
        os.system(comando_final)
    else:
        print(f"A extensão '{extensao}' não é suportada para execução.")

def verificar_arquivo():
    nome_arquivo = input("Por favor, insira o nome do arquivo (sem extensão): ")
    extensao = input("Por favor, insira a extensão do arquivo: ")
    caminho_arquivo = input("Por favor, insira o caminho onde o arquivo está localizado: ")

    executar_arquivo(nome_arquivo, extensao, caminho_arquivo)

verificar_arquivo()
