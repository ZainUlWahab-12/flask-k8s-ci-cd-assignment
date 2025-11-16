# Minimal Dockerfile for a simple Python app
FROM python:3.11-slim

# Create app directory
WORKDIR /app

# Install dependencies first (leverage layer cache)
COPY requirements.txt /app/
RUN python -m pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the package code and tests (if you want tests in image)
COPY . /app

# Default command — change as appropriate
CMD ["python", "-c", "import mypackage.calculator as c; print(c.add(2,3))"]