# --- builder stage ---
FROM python:3.11-slim AS builder
ENV PYTHONDONTWRITEBYTECODE=1
ENV PIP_NO_CACHE_DIR=1

WORKDIR /app

# Install build deps (if you need them); minimal here
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .

# Install into a prefix so we can copy only installed packages into final image
RUN pip install --upgrade pip \
    && pip install --prefix=/install -r requirements.txt

COPY . .

# --- final stage ---
FROM python:3.11-slim
ENV PYTHONDONTWRITEBYTECODE=1
ENV PATH=/install/bin:$PATH

WORKDIR /app

# Copy installed packages and app source
COPY --from=builder /install /install
COPY --from=builder /app /app

# Clean apt cache in final image (nothing installed, but safe practice)
RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

EXPOSE 5000

# For quick testing you can run python app.py. For production change to gunicorn:
# CMD ["gunicorn", "--bind", "0.0.0.0:5000", "app:app", "--workers", "3"]
CMD ["python", "app.py"]