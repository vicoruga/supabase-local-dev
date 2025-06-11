#!/bin/bash

# Script para crear el repositorio de Supabase Local en GitHub
# Ejecutar paso a paso

echo "🚀 Preparando repositorio de Supabase Local para GitHub..."

# 1. Crear directorio del proyecto
# echo "📁 Creando estructura del proyecto..."
# mkdir -p supabase-local-dev
#cd supabase-local-dev

# 2. Crear estructura de directorios
mkdir -p init-scripts docs

# 3. Crear archivo .env.example (sin credenciales reales)
cat > .env.example << 'EOF'
# PostgreSQL Configuration
POSTGRES_PASSWORD=your_postgres_password
POSTGRES_DB=supabase
POSTGRES_USER=postgres

# JWT Configuration - Generar con el script setup-supabase.sh
JWT_SECRET=your-super-secret-jwt-token-with-at-least-32-characters
ANON_KEY=your_anon_key_here
SERVICE_ROLE_KEY=your_service_role_key_here

# URLs
SUPABASE_URL=http://localhost:8000
SUPABASE_PUBLIC_URL=http://localhost:8000
SITE_URL=http://localhost:3000
API_EXTERNAL_URL=http://localhost:8000

# Configuración adicional
PROJECT_REF=local
POSTGRES_PORT=5432
EOF

# 4. Crear .gitignore
cat > .gitignore << 'EOF'
# Environment variables
.env

# Docker volumes
**/data/
volumes/

# Logs
*.log
logs/

# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# IDE
.vscode/
.idea/
*.swp
*.swo

# Node modules (si añades scripts en Node.js)
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Backup files
*.bak
*.backup

# Temporary files
tmp/
temp/
EOF

# 5. Crear LICENSE (MIT)
cat > LICENSE << 'EOF'
MIT License

Copyright (c) 2025 Supabase Local Development

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

# 6. Crear documentación adicional
cat > docs/troubleshooting.md << 'EOF'
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
EOF

cat > docs/api-examples.md << 'EOF'
# 📡 Ejemplos de Uso de la API

## Configuración Inicial

### JavaScript/TypeScript
```javascript
import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'http://localhost:8000'
const supabaseAnonKey = 'tu_anon_key_aqui'

export const supabase = createClient(supabaseUrl, supabaseAnonKey)
```

### cURL
```bash
# Variables de entorno
export SUPABASE_URL="http://localhost:8000"
export ANON_KEY="tu_anon_key_aqui"
```

## Ejemplos de Autenticación

### Registro de Usuario
```javascript
const { data, error } = await supabase.auth.signUp({
  email: 'user@example.com',
  password: 'your-password'
})
```

```bash
curl -X POST "$SUPABASE_URL/auth/v1/signup" \
  -H "apikey: $ANON_KEY" \
  -H "Content-Type: application/json" \
  -d '{
    "email": "user@example.com",
    "password": "your-password"
  }'
```

### Login
```javascript
const { data, error } = await supabase.auth.signInWithPassword({
  email: 'user@example.com',
  password: 'your-password'
})
```

## Ejemplos de Base de Datos

### Crear una tabla
```sql
-- Ejecutar en Studio o psql
CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title TEXT NOT NULL,
  content TEXT,
  created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Habilitar RLS
ALTER TABLE posts ENABLE ROW LEVEL SECURITY;
```

### Insertar datos
```javascript
const { data, error } = await supabase
  .from('posts')
  .insert([
    { title: 'Mi primer post', content: 'Contenido del post' }
  ])
```

### Leer datos
```javascript
const { data, error } = await supabase
  .from('posts')
  .select('*')
```

### Suscripción en tiempo real
```javascript
const subscription = supabase
  .channel('posts')
  .on('postgres_changes', 
    { event: '*', schema: 'public', table: 'posts' },
    (payload) => {
      console.log('Cambio detectado:', payload)
    }
  )
  .subscribe()
```

## Ejemplos de Storage

### Crear un bucket
```javascript
const { data, error } = await supabase.storage.createBucket('avatars', {
  public: true
})
```

### Subir archivo
```javascript
const { data, error } = await supabase.storage
  .from('avatars')
  .upload('public/avatar.png', file)
```

### Obtener URL pública
```javascript
const { data } = supabase.storage
  .from('avatars')
  .getPublicUrl('public/avatar.png')
```

## Testing

### Test de conexión
```bash
# Verificar que la API responde
curl -H "apikey: $ANON_KEY" "$SUPABASE_URL/rest/v1/"

# Test de autenticación
curl -X POST "$SUPABASE_URL/auth/v1/settings" \
  -H "apikey: $ANON_KEY"
```

### Test de base de datos
```bash
# Conectar directamente a PostgreSQL
psql postgresql://postgres:postgres@localhost:5432/supabase

# Test básico
\dt  # Listar tablas
SELECT version();  # Versión de PostgreSQL
```
EOF

echo "✅ Estructura del proyecto creada"
echo ""
echo "📋 Próximos pasos:"
echo "1. Copia todos los archivos generados anteriormente a este directorio"
echo "2. Ejecuta los siguientes comandos:"
echo ""
echo "# Inicializar repositorio Git"
echo "git init"
echo ""
echo "# Añadir archivos"
echo "git add ."
echo ""
echo "# Primer commit"
echo "git commit -m \"🚀 Initial commit: Supabase local development environment\""
echo ""
echo "# Crear repositorio en GitHub (vía web o CLI)"
echo "# Opción 1: GitHub CLI"
echo "gh repo create supabase-local-dev --public --description \"Complete Supabase local development environment with Docker Compose\""
echo ""
echo "# Opción 2: Manualmente en https://github.com/new"
echo "# Nombre: supabase-local-dev"
echo "# Descripción: Complete Supabase local development environment with Docker Compose"
echo ""
echo "# Conectar con el repositorio remoto"
echo "git branch -M main"
echo "git remote add origin https://github.com/vicoruga/supabase-local-dev.git"
echo "git push -u origin main"
echo ""
echo "🎉 ¡Listo! Tu repositorio estará disponible en GitHub"