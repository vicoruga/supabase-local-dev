🚀 Supabase Local Development Environment
Una configuración completa y funcional de Supabase para desarrollo local usando Docker Compose.

✨ Características
✅ Configuración completa de todos los servicios de Supabase
✅ Claves JWT válidas generadas automáticamente
✅ Healthchecks para todos los servicios
✅ Kong Gateway completamente configurado
✅ Scripts de verificación y debugging
✅ Inicialización automática de base de datos
✅ Documentación completa
🏗️ Servicios Incluidos
Servicio	Puerto	Descripción
PostgreSQL	5432	Base de datos principal
PostgREST	3000	API REST automática
Studio	3001	Interfaz web de administración
Realtime	4000	Subscripciones en tiempo real
Storage	5000	API de almacenamiento de archivos
Kong Gateway	8000	API Gateway principal
Kong Admin	8001	API de administración de Kong
Auth (GoTrue)	9999	Servicio de autenticación
ImgProxy	5001	Transformación de imágenes
🚀 Inicio Rápido
1. Clonar y Configurar
bash
# Clonar el repositorio
git clone https://github.com/tu-usuario/supabase-local-dev.git
cd supabase-local-dev

# Ejecutar configuración automática
chmod +x setup-supabase.sh
./setup-supabase.sh
2. Levantar los Servicios
bash
# Iniciar todos los servicios
docker compose up -d

# Ver logs en tiempo real
docker compose logs -f
3. Verificar Funcionamiento
bash
# Ejecutar script de verificación
chmod +x verify-supabase.sh
./verify-supabase.sh
🎯 Acceso a Servicios
Una vez que todos los servicios estén funcionando:

📊 Supabase Studio: http://localhost:3001
🔌 API Gateway: http://localhost:8000
📡 PostgREST (directo): http://localhost:3000
🗄️ Base de datos: postgresql://postgres:postgres@localhost:5432/supabase
🔑 Configuración para tu Aplicación
Usa estas credenciales en tu aplicación:

javascript
import { createClient } from '@supabase/supabase-js'

const supabaseUrl = 'http://localhost:8000'
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0'

export const supabase = createClient(supabaseUrl, supabaseAnonKey)
O en variables de entorno:

env
NEXT_PUBLIC_SUPABASE_URL=http://localhost:8000
NEXT_PUBLIC_SUPABASE_ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0
🛠️ Comandos Útiles
bash
# Ver estado de todos los servicios
docker compose ps

# Ver logs de un servicio específico
docker compose logs -f [servicio]

# Reiniciar un servicio
docker compose restart [servicio]

# Acceder a la base de datos
psql postgresql://postgres:postgres@localhost:5432/supabase

# Parar todos los servicios
docker compose down

# Parar y eliminar volúmenes (⚠️ elimina datos)
docker compose down -v
📁 Estructura del Proyecto
supabase-local-dev/
├── docker-compose.yml      # Configuración principal de Docker
├── kong.yml               # Configuración del API Gateway
├── .env                   # Variables de entorno
├── .env.example           # Ejemplo de variables de entorno
├── setup-supabase.sh      # Script de configuración automática
├── verify-supabase.sh     # Script de verificación
├── init-scripts/          # Scripts de inicialización de BD
│   └── 01-init.sql        # Configuración inicial de la base de datos
├── docs/                  # Documentación adicional
│   ├── troubleshooting.md # Guía de solución de problemas
│   └── api-examples.md    # Ejemplos de uso de la API
└── README.md             # Este archivo
🔧 Solución de Problemas
Puertos ocupados
Si algún puerto está ocupado, puedes cambiarlos en docker-compose.yml:

yaml
ports:
  - "NUEVO_PUERTO:PUERTO_INTERNO"
Servicios no inician
Verificar que Docker esté corriendo
Verificar puertos disponibles
Revisar logs: docker compose logs [servicio]
Error de permisos
En Linux/Mac, asegurar permisos de ejecución:

bash
chmod +x *.sh
Base de datos no responde
bash
# Verificar estado del contenedor
docker compose ps db

# Ver logs de PostgreSQL
docker compose logs db

# Reiniciar solo la base de datos
docker compose restart db
🤝 Contribuir
Fork el proyecto
Crea una rama para tu feature (git checkout -b feature/AmazingFeature)
Commit tus cambios (git commit -m 'Add some AmazingFeature')
Push a la rama (git push origin feature/AmazingFeature)
Abre un Pull Request
📋 Requisitos
Docker >= 20.10
Docker Compose >= 2.0
Git
Bash (para scripts de configuración)
⚠️ Consideraciones de Producción
Esta configuración está diseñada solo para desarrollo local. Para producción:

Usar Supabase Cloud o configuración de producción apropiada
Cambiar todas las contraseñas y claves
Configurar SSL/TLS
Implementar backups
Configurar monitoreo
📝 Licencia
Este proyecto está bajo la Licencia MIT. Ver LICENSE para más detalles.

🙏 Agradecimientos
Supabase por crear esta increíble plataforma
Kong por el API Gateway
PostgREST por la API automática
La comunidad open source
⭐ Si este proyecto te fue útil, considera darle una estrella en GitHub!

