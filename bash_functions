# Docker

# Lista los contenedores de Docker Compose
# Uso: dcps [fichero-compose]
dcps() {
    if [ -z "$1" ]; then
        docker compose ps
    else
        docker compose -f "$1" ps
    fi
}

# Abre una shell dentro de un contenedor Docker.
# Usa bash si el contenedor lo tiene y, si no (Alpine y similares), sh.
# Uso: dexec <contenedor>
dexec() {
    if [ -z "$1" ]; then
        echo "Uso: dexec <contenedor>" >&2
        return 1
    fi
    docker exec -it "$1" sh -c 'command -v bash >/dev/null && exec bash || exec sh'
}

# Ejecuta un comando, con todos sus argumentos, en un servicio de Docker Compose.
# Uso: dcexec <servicio> <comando> [argumentos...]
# Ejemplo: dcexec web ls -la /app
dcexec() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Uso: dcexec <servicio> <comando> [argumentos...]" >&2
        return 1
    fi
    local servicio="$1"
    shift
    docker compose exec "$servicio" "$@"
}
