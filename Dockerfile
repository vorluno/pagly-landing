# Pagly Landing - Sitio estático para CapRover
FROM nginx:alpine

# Eliminar configuración por defecto de nginx
RUN rm -rf /usr/share/nginx/html/*

# Copiar archivos estáticos
COPY index.html /usr/share/nginx/html/
COPY styles.css /usr/share/nginx/html/
COPY script.js /usr/share/nginx/html/
COPY assets/ /usr/share/nginx/html/assets/

# Configuración nginx: SPA-style fallback a index.html para rutas directas
RUN echo 'server { \
  listen 80; \
  root /usr/share/nginx/html; \
  index index.html; \
  location / { \
    try_files $uri $uri/ /index.html; \
  } \
  location ~* \.(css|js|svg|ico|html)$ { \
    expires 7d; \
    add_header Cache-Control "public, immutable"; \
  } \
}' > /etc/nginx/conf.d/default.conf

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
