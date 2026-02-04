FROM python:3.12-slim

# Install nginx
RUN apt-get update \
  && apt-get install -y --no-install-recommends nginx \
  && rm -rf /var/lib/apt/lists/*

# Install python deps
COPY requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt

# Copy app + site + nginx config
COPY app.py /app.py
COPY index.html /usr/share/nginx/html/index.html
COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

# Start Flask in the background and keep nginx in foreground
CMD sh -c "python /app.py & nginx -g 'daemon off;'"