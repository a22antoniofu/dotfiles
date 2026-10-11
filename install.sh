#!/bin/bash
# Instala los dotfiles de bash enlazándolos en el $HOME.
# Si ya existe un fichero de verdad (no un enlace), lo guarda como .bak antes.
# Codespaces ejecuta este script solo si el repo está configurado como dotfiles.

set -Eeuo pipefail
trap 'echo "Fallo en la línea $LINENO: $BASH_COMMAND" >&2' ERR

# Carpeta donde está este script (el repo), se lance desde donde se lance
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

enlaza() {
    local origen="$REPO/$1"
    local destino="$HOME/$2"

    if [ -e "$destino" ] && [ ! -L "$destino" ]; then
        mv "$destino" "$destino.bak"
        echo "Copia de seguridad: $destino.bak"
    fi
    ln -sfn "$origen" "$destino"
    echo "Enlazado: $destino -> $origen"
}

enlaza bashrc         .bashrc
enlaza bash_aliases   .bash_aliases
enlaza bash_functions .bash_functions
enlaza inputrc        .inputrc

echo "Listo. Abre una terminal nueva o ejecuta: exec bash"
