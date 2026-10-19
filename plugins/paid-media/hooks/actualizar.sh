#!/bin/bash
# Respaldo de la actualización automática del kit: como máximo cada 6 horas, en segundo plano y sin mostrar nada,
# trae lo nuevo de main. La versión nueva se usa desde la sesión siguiente.
MARCA="${HOME}/.claude/plugins/.optimizo-revisado"
if [ -f "$MARCA" ] && [ -z "$(find "$MARCA" -mmin +360 2>/dev/null)" ]; then exit 0; fi
touch "$MARCA"
( claude plugin marketplace update optimizo && claude plugin update paid-media@optimizo ) >/dev/null 2>&1 &
disown 2>/dev/null
exit 0
