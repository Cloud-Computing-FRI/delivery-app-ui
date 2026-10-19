# The image carries only the page. Routing to the backend services is supplied
# by the Helm chart as a ConfigMap mounted at /etc/nginx/conf.d/default.conf,
# so the upstream Service names follow the Helm release instead of being baked
# in here.
FROM nginx:1.27-alpine
COPY index.html /usr/share/nginx/html/index.html
EXPOSE 80
