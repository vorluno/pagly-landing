# Pasos para subir Pagly Landing a CapRover

## ✅ Verificación rápida (todo correcto)

- **Dockerfile**: copia `index.html`, `styles.css`, `script.js` y `assets/`; nginx escucha en puerto **80**.
- **captain-definition**: apunta a `./Dockerfile`.
- **index.html**: rutas relativas (`styles.css`, `assets/...`) y `/assets/` para el favicon; funcionan bien servidas desde la raíz.

---

## Pasos para desplegar

### 1. En el dashboard de CapRover

- Entra a tu servidor CapRover.
- Abre la **app** donde quieres desplegar la landing (la que ya tiene dominio).
- Anota el **nombre de la app** (ej: `pagly-landing` o `landing`).

### 2. Deploy desde GitHub (recomendado)

1. En la app, pestaña **Deployment**.
2. En **Method 2: Deploy from GitHub/Bitbucket/GitLab**:
   - **GitHub Repository**: `vorluno/pagly-landing` (o tu usuario si cambiaste).
   - **Branch**: `master`.
   - **Username**: tu usuario de GitHub (o deja vacío si el repo es público).
   - **Password**: un **Personal Access Token** de GitHub (no tu contraseña).
     - GitHub → Settings → Developer settings → Personal access tokens → Generate new token.
     - Marca al menos el permiso `repo`.
3. Pulsa **Save and Update** (o **Deploy** si ya estaba guardado).
4. CapRover clonará el repo, construirá la imagen con el `Dockerfile` y desplegará. Espera a que termine el build.

### 3. O deploy por tarball (alternativa)

Desde la raíz del proyecto en tu PC:

```powershell
cd c:\pagly-landing
tar -cvf deploy.tar --exclude='.git' --exclude='*.md' .
```

Luego en CapRover:

- **Method 1: Upload Tar File** → sube `deploy.tar` y haz **Deploy**.

### 4. Configuración de la app en CapRover

- **App Type**: Web App (HTTP).
- **HTTP Port**: **80** (nginx escucha en 80 dentro del contenedor).
- **Persistent Data**: no hace falta; es sitio estático.
- Dominio: el que ya tienes asignado a la app.

### 5. Comprobar

- Abre la URL de tu app (ej: `https://pagly.io` o `https://tu-app.tudominio.com`).
- Deberías ver la landing: logo, estilos, menú y enlaces funcionando.

---

## Si algo falla

- **Build falla**: revisa los logs en CapRover; suele ser por falta de `Dockerfile` o `captain-definition` en la raíz del repo.
- **Página en blanco o 404**: confirma que HTTP Port de la app sea **80**.
- **CSS/JS no cargan**: las rutas en `index.html` están bien; si usas subruta (ej: `/landing/`), habría que ajustar base path (en tu caso no aplica si el dominio es la raíz).

---

**Resumen**: Con la app y el dominio ya creados en CapRover, solo falta hacer el deploy (por GitHub o por tarball) y tener el puerto **80** configurado. Los archivos del repo están listos para subir.
