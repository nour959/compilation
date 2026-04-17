#!/bin/bash
set -e

echo "Nettoyage..."
rm -f langage1.tab.c langage1.tab.h lex.yy.c nutrilang

echo "Generation du parser (Bison)..."
bison -d langage1.y

echo "Generation du lexer (Flex)..."
flex langage1.l

echo "Compilation GCC..."
gcc langage1.tab.c lex.yy.c -o nutrilang -lm

echo "Compilation reussie ! Lancez avec : ./nutrilang"