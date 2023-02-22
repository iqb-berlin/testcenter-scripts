#!/bin/sh

BOM='\xEF\xBB\xBF'
if ! sed -n "1{/^$BOM/q1}" "$1"; then
    echo "Already has BOM" >&2
    exit 1
fi
sed -i "1s/^/$BOM/" "$1"