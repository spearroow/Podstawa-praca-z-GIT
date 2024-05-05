#!/bin/bash

function logs {
    # Wskazuje liczbę plików do utworzenia (domyślnie 100, chyba że podano argument)
    local count=${2:-100}

    for i in $(seq 1 $count); do
        filename="log${i}.txt"
        {
            echo "$filename"
            echo "$0"
            date
        } > "$filename"
    done
}

function clone {
    # Klonuje całe repozytorium do katalogu, w którym został uruchomiony skrypt
    git clone https://github.com/spearroow/Podstawa-praca-z-GIT.git
}

function init {
    clone
    echo "Current Directory: $PWD"
    export PATH="$PATH:$PWD"
    echo "Updated PATH: $PATH"
}

function error {
    # Wskazuje liczbę folderów i plików do utworzenia (domyślnie 100)
    local count=${2:-100}

    for i in $(seq 1 $count); do
        dir_name="error${i}"
        file_name="error${i}.txt"

        if [ ! -d "$dir_name" ]; then
            mkdir "$dir_name"
        fi

        {
            echo "$file_name"
            echo "$0"
            date
        } > "$dir_name/$file_name"
    done
}

function help {
    echo "Skrypt: $0"
    echo "Opcje:"
    echo "  --date, -d       Wyświetla dzisiejszą datę."
    echo "  --logs, -l [N]   Tworzy N plików logx.txt (domyślnie 100), w których wpisuje nazwę, skrypt i datę."
    echo "  --init           Klonuje repozytorium GIT do bieżącego katalogu."
    echo "  --error, -e [N]  Tworzy N folderów errorx, w których jest plik z nazwą, skryptem i datą."
    echo "  --help, -h       Wyświetla wszystkie dostępne opcje."
    echo "Przykłady użycia:"
    echo "  ./skrypt.sh --logs"
    echo "  ./skrypt.sh -l 50"
}

function menu {
    if [ -z "$1" ]; then
        help
        return
    fi

    case $1 in
        --date | -d) date ;;
        --logs | -l) logs "$@" ;;
        --init) init ;;
        --error | -e) error "$@" ;;
        --help | -h) help ;;
        *) echo "Nieznana opcja: $1"; help ;;
    esac
}

function main {
    menu "$@"
}

main "$@"