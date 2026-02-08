# Estructura del proyecto Pagly Landing + Despliegue CapRover

## Estructura de archivos (para verificar antes de subir)

```
pagly-landing/
├── index.html              # Página principal
├── styles.css              # Estilos
├── script.js               # Lógica (menú móvil, animaciones, etc.)
├── assets/
│   ├── pagly-brand.html
│   ├── pagly-icon.svg
│   ├── pagly-logo-dark.svg
│   └── pagly-logo-light.svg
├── Dockerfile              # Imagen para CapRover
├── captain-definition      # Configuración CapRover (usa el Dockerfile)
├── .dockerignore           # Excluye archivos del build
└── ESTRUCTURA-Y-CAPROVER.md  # Este archivo
```

## Checklist antes de subir a CapRover

- [ ] **index.html** existe y las rutas a CSS/JS/assets son correctas (relativas: `styles.css`, `script.js`, `assets/...`).
- [ ] **assets/** contiene: `pagly-icon.svg`, `pagly-logo-dark.svg`, `pagly-logo-light.svg`, `pagly-brand.html`.
- [ ] **Dockerfile** y **captain-definition** están en la raíz del repo.
- [ ] No hay dependencias de `node_modules` ni build (es sitio estático puro).
- [ ] En CapRover: la app tiene puerto **80** (o el que asigne CapRover) y está accesible por HTTP/HTTPS según tu configuración.

## Cómo desplegar en CapRover

1. **Desde la raíz del proyecto** (donde están `Dockerfile` y `captain-definition`):
   ```bash
   caprover deploy
   ```
   O si usas tarball:
   ```bash
   tar -cvf deploy.tar --exclude='.git' --exclude='*.md' .
   caprover deploy -t deploy.tar
   ```

2. En el dashboard de CapRover:
   - Crea una nueva app (ej: `pagly-landing`).
   - Método de deploy: “Deploy from GitHub/Branch” o “Upload tar” según cómo despliegues.
   - Si subes por Git, la raíz del repo debe ser la que contiene `Dockerfile` y `captain-definition`.

3. Tras el deploy, la URL será la que tengas configurada para esa app (ej: `https://pagly-landing.tudominio.com`).

## Notas

- El **Dockerfile** usa `nginx:alpine`, copia `index.html`, `styles.css`, `script.js` y la carpeta `assets/` a `/usr/share/nginx/html/`.
- **captain-definition** indica a CapRover que use ese `Dockerfile` para construir la imagen.
- Si añades más archivos estáticos (por ejemplo en `assets/`), no hace falta tocar el Dockerfile si ya copias toda la carpeta `assets/`.

Si quieres, en el siguiente paso podemos revisar juntos la lista de archivos que incluye tu `deploy.tar` o tu rama antes de hacer el deploy.
