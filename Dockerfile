FROM python:3.11
WORKDIR /app
COPY app /app
RUN pip install -r requirements.txt
CMD ["python", "main.py"]
EXPOSE 8080
