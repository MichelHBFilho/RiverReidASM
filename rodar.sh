#!/bin/bash

# Interrompe o script imediatamente se algum comando falhar
set -e

# Salva o caminho da pasta inicial
PASTA_INICIAL=$(pwd)

echo "=== 1. Compilando o Montador ==="
cd "$PASTA_INICIAL/Assembler_Source"
make
mv montador "$PASTA_INICIAL/"

echo "=== 2. Compilando o Simulador ==="
cd "$PASTA_INICIAL/Simulator_Source"
sh ./compila.sh
mv sim "$PASTA_INICIAL/"

echo "=== 3. Executando o Joguinho ==="
cd "$PASTA_INICIAL"
./montador joguinho.asm joguinho.mif && ./sim joguinho.mif charmap.mif
