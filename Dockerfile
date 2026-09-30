FROM python:3.11-slim AS builder

WORKDIR /build
COPY requirements.txt .
RUN pip install --prefix=/install -r requirements.txt

FROM python:3.11-slim

WORKDIR /app
RUN apt-get update && apt-get install -y curl

COPY --from=builder/install/usr/local
COPY main.py .

EXPOSE 8000

HEALTHCHECK CMD curl -f http://localhost:8000/health

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
