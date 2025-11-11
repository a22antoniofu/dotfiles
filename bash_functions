# Docker

# Lista los contenedores de Docker Compose

dcps() {
    if [ -z "$1" ]; then
        docker compose ps
    else
        docker compose -f $1 ps
    fi
}

# Ejecutar bash dentro de un contenedor Docker

dexec() {
    if [ -z "$1" ]; then
        echo "Uso: dexec <container_name_or_id>"
    else
        docker exec -it $1 /bin/bash
    fi
}

# Ejecutar comandos dentro de un contenedor Docker con docker compose

dcexec() {
    if [ -z "$1" ] || [ -z "$2" ]; then
        echo "Uso: dcexec <service_name> <command>"
    else
        docker compose exec $1 $2
    fi
}

