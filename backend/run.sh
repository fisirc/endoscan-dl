#!/bin/bash

# EndoScan Backend - Run Script

echo "🚀 Iniciando EndoScan Backend..."
echo ""

# Check if venv exists
if [ ! -d "venv" ]; then
    echo "⚠️  Virtual environment no encontrado."
    echo "Creando venv..."
    python -m venv venv
fi

# Activate venv
echo "📦 Activando virtual environment..."
source venv/bin/activate

# Install/update dependencies
echo "📚 Instalando dependencias..."
pip install -q -r requirements.txt

# Start server
echo ""
echo "✅ Iniciando servidor en http://localhost:8000"
echo "📖 Documentación interactiva en http://localhost:8000/docs"
echo ""
echo "Presiona Ctrl+C para detener el servidor"
echo ""

uvicorn main:app --reload --host 0.0.0.0 --port 8000
