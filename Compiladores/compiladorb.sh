#!/bin/bash

executar_arquivo() {
    local nome_arquivo=$1
    local extensao=$2
    local caminho_arquivo=$3
    local nome_c_arquivo="${nome_arquivo}.${extensao}"
    local caminho_completo="${caminho_arquivo}/${nome_c_arquivo}"

    if [ ! -f "$caminho_completo" ]; then
        echo "O arquivo especificado não existe."
        return
    fi

    case "$extensao" in
        html)
            porta=8000
            cd "$caminho_arquivo" || return
            python3 -m http.server $porta &>/dev/null &
            echo "Servidor HTTP iniciado em http://localhost:${porta}"
            xdg-open "http://localhost:${porta}/${nome_c_arquivo}" &>/dev/null
            return
            ;;
        css)
            echo "Visualização de arquivos CSS não é suportada neste modo."
            return
            ;;
    esac

    case "$extensao" in
        py) compilador="python3" ;;
        rb) compilador="ruby" ;;
        cpp) compilador="g++" ;;
        c) compilador="gcc" ;;
        cs) compilador="mcs" ;;
        java) compilador="java" ;;
        js) compilador="node" ;;
        php) compilador="php" ;;
        pl) compilador="perl" ;;
        lua) compilador="lua" ;;
        swift) compilador="swiftc" ;;
        r) compilador="Rscript" ;;
        go) compilador="go run" ;;
        scala) compilador="scala" ;;
        pas) compilador="fpc" ;;
        rs) compilador="rustc" ;;
        *)
            echo "A extensão '$extensao' não é suportada para execução."
            return
            ;;
    esac

    echo "$compilador"

    if [ "$extensao" = "c" ] || [ "$extensao" = "cpp" ] || [ "$extensao" = "cs" ]; then
        comando="$compilador -o ${nome_arquivo} ${nome_c_arquivo} && ./${nome_arquivo}"
    else
        comando="$compilador ${nome_c_arquivo}"
    fi
    cd "$caminho_arquivo" && $comando
}

verificar_arquivo() {
    read -p "Por favor, insira o nome do arquivo (sem extensão): " nome_arquivo
    read -p "Por favor, insira a extensão do arquivo: " extensao
    read -p "Por favor, insira o caminho onde o arquivo está localizado: " caminho_arquivo

    executar_arquivo "$nome_arquivo" "$extensao" "$caminho_arquivo"
}

verificar_arquivo

