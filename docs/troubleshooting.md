# 🔧 Guía de Solución de Problemas

## Problemas Comunes

### 1. Puerto ya en uso
**Error**: `port is already allocated`

**Solución**:
```bash
# Verificar qué proceso usa el puerto
lsof -i :PORT_NUMBER

# Cambiar el puerto en docker-compose.yml
ports:
  - "NUEVO_PUERTO:PUERTO_INTERNO"
```

### 2. Contenedores no inician
**Síntomas**: Servicios en estado "unhealthy" o "exited"

**Pasos de diagnóstico**:
```bash
# Ver estado detallado
docker compose ps

# Ver logs específicos
docker compose logs [servicio]

# Verificar recursos del sistema
docker system df
```

### 3. Error de conexión a la base de datos
**Error**: `could not connect to server`

**Soluciones**:
```bash
# Verificar que PostgreSQL esté corriendo
docker compose ps db

# Reiniciar solo la base de datos
docker compose restart db

# Verificar logs de PostgreSQL
docker compose logs db

# Verificar conectividad
docker compose exec db pg_isready -U postgres
```

### 4. Kong no puede conectar con servicios
**Síntomas**: Error 502/503 en endpoints

**Soluciones**:
```bash
# Verificar configuración de Kong
docker compose logs kong

# Validar kong.yml
docker compose exec kong kong config parse /var/lib/kong/kong.yml

# Reiniciar Kong
docker compose restart kong
```

### 5. Studio no carga
**Síntomas**: Página en blanco o error de conexión

**Verificaciones**:
```bash
# Verificar que todos los servicios dependientes estén corriendo
docker compose ps

# Verificar logs de Studio
docker compose logs studio

# Verificar que las variables de entorno estén correctas
docker compose exec studio env | grep SUPABASE
```

## Comandos de Diagnóstico

```bash
# Estado general del sistema
docker system info

# Uso de recursos
docker stats

# Logs de todos los servicios
docker compose logs --tail=100

# Reinicio completo
docker compose down && docker compose up -d

# Limpiar todo y empezar de nuevo (⚠️ elimina datos)
docker compose down -v
docker system prune -f
```

## Problemas Específicos por SO

### Windows
- Habilitar WSL2
- Configurar Docker Desktop correctamente
- Verificar que no haya conflictos con antivirus

### macOS
- Aumentar recursos asignados a Docker Desktop
- Verificar permisos de archivos

### Linux
- Verificar que el usuario esté en el grupo docker
- Configurar systemd si es necesario
