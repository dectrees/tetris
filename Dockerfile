# The game is a single self-contained HTML file, so a static file server is all
# that's needed. nginx:alpine keeps the image at roughly 50 MB.
FROM nginx:1.31-alpine

# Replaces the stock nginx landing page with the game itself
COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

HEALTHCHECK --interval=30s --timeout=3s --start-period=3s --retries=3 \
  CMD wget -q --spider http://127.0.0.1/ || exit 1

CMD ["nginx", "-g", "daemon off;"]
