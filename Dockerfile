FROM python:3.11 AS builder
WORKDIR /app
COPY app /app
RUN pip install -r requirements.txt
COPY . .
CMD ["python", "main.py"]

ARG FLASK_PORT=8080
ENV FLASK_PORT=$FLASK_PORT

FROM nginx:alpine
COPY nginx.conf /etc/nginx/nginx.conf
COPY --from=builder /app /app
EXPOSE $FLASK_PORT
CMD ["nginx", "-g", "daemon off;"]
