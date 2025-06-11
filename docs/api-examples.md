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
