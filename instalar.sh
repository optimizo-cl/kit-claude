#!/bin/bash
# Kit de Optimizo para Mac: instala o repara todo lo que se usa para trabajar con Claude.
# Se puede correr las veces que quieras: lo que ya está al día no se toca.
#   1. Medula (app de escritorio). Después se actualiza sola.
#   2. Claude Code. Después se actualiza solo.
#   3. Conector de Medula en Claude Code (el login se hace una vez, con /mcp).
#   4. Kit «paid-media» (método, comandos y conexión al cerebro de Paid Media). Se actualiza solo desde main.
# Lo que baja este script no queda en cuarentena: macOS abre Medula sin preguntar.
set -euo pipefail

SERVIDOR="https://medula.condorai.cl"
DESTINO="${MEDULA_DESTINO:-/Applications/Medula.app}"
KIT_REPO="${KIT_REPO:-optimizo-cl/kit-claude}"

paso() { printf '\n\033[1m%s\033[0m\n' "$1"; }
listo() { printf '  ✓ %s\n' "$1"; }

[ "$(uname)" = "Darwin" ] || { echo "Este instalador es para Mac."; exit 1; }

# ── 1. Medula ───────────────────────────────────────────────────────────
paso "1/4 · Medula"
YML="$(curl -fsSL "$SERVIDOR/descargas/mac/latest-mac.yml")"
VERSION="$(printf '%s\n' "$YML" | sed -n 's/^version:[[:space:]]*//p' | tr -d "'\"")"
ZIP="$(printf '%s\n' "$YML" | sed -n 's/^path:[[:space:]]*//p' | tr -d "'\"")"
SHA="$(printf '%s\n' "$YML" | sed -n 's/^sha512:[[:space:]]*//p' | tr -d "'\"")"
[ -n "$VERSION" ] && [ -n "$ZIP" ] && [ -n "$SHA" ] || { echo "  No encontré la versión publicada de Medula. Intenta en un rato."; exit 1; }
ACTUAL="$(defaults read "$DESTINO/Contents/Info.plist" CFBundleShortVersionString 2>/dev/null || true)"
if [ "$ACTUAL" = "$VERSION" ]; then
  listo "Medula $VERSION ya está instalada"
else
  TMP="$(mktemp -d)"
  trap 'rm -rf "$TMP"' EXIT
  echo "  Bajando Medula $VERSION…"
  curl -fL --progress-bar -o "$TMP/$ZIP" "$SERVIDOR/descargas/mac/$ZIP"
  [ "$(openssl dgst -sha512 -binary "$TMP/$ZIP" | base64)" = "$SHA" ] || { echo "  La descarga no coincide con su huella. No se instaló nada."; exit 1; }
  ditto -x -k "$TMP/$ZIP" "$TMP/app"
  if pgrep -xq Medula; then osascript -e 'tell application id "cl.condorai.medula" to quit' >/dev/null 2>&1 || true; sleep 2; fi
  rm -rf "$DESTINO"
  ditto "$TMP/app/Medula.app" "$DESTINO"
  listo "Medula $VERSION instalada en Aplicaciones"
fi

# ── 2. Claude Code ──────────────────────────────────────────────────────
paso "2/4 · Claude Code"
export PATH="$HOME/.local/bin:$PATH"
if command -v claude >/dev/null 2>&1; then
  listo "Claude Code ya está instalado ($(claude --version 2>/dev/null | head -1))"
else
  curl -fsSL https://claude.ai/install.sh | bash
  listo "Claude Code instalado"
fi

# ── 3. Conector de Medula ───────────────────────────────────────────────
paso "3/4 · Conector de Medula (tu empresa)"
if claude mcp get medula >/dev/null 2>&1; then
  listo "El conector de Medula ya está agregado"
else
  claude mcp add --transport http -s user medula "$SERVIDOR/mcp" >/dev/null
  listo "Conector de Medula agregado"
fi

# ── 4. Kit paid-media ───────────────────────────────────────────────────
paso "4/4 · Kit de Paid Media"
if claude plugin marketplace list 2>/dev/null | grep -q "optimizo"; then
  claude plugin marketplace update optimizo >/dev/null 2>&1 || true
  listo "Catálogo de Optimizo al día"
else
  claude plugin marketplace add "$KIT_REPO" >/dev/null
  listo "Catálogo de Optimizo agregado"
fi
if claude plugin list 2>/dev/null | grep -q "paid-media@optimizo"; then
  listo "Kit paid-media ya instalado"
else
  claude plugin install paid-media@optimizo >/dev/null
  listo "Kit paid-media instalado"
fi
# Que el catálogo se actualice solo (los de terceros vienen con la actualización apagada).
osascript -l JavaScript - "$HOME/.claude/plugins/known_marketplaces.json" >/dev/null <<'JS'
function run(argv) {
  ObjC.import("Foundation");
  const ruta = argv[0];
  const texto = $.NSString.stringWithContentsOfFileEncodingError(ruta, $.NSUTF8StringEncoding, null);
  if (texto.isNil()) return;
  const datos = JSON.parse(texto.js);
  if (!datos.optimizo || datos.optimizo.autoUpdate) return;
  datos.optimizo.autoUpdate = true;
  $(JSON.stringify(datos, null, 2)).writeToFileAtomicallyEncodingError(ruta, true, $.NSUTF8StringEncoding, null);
}
JS
listo "Actualización automática del kit encendida"

paso "Listo."
echo "  · Abre Medula desde Aplicaciones y entra con tu correo."
echo "  · En una terminal escribe: claude → /mcp → medula → Autenticar (elige tu empresa)."
echo "  · En el mismo /mcp → plugin:paid-media:paid-media → Autenticar (elige la empresa «Paid Media»)."
echo "  · Prueba: /paid-media:ideas <marca> <campaña>"
