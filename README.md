# Kit de Claude · Optimizo

Todo lo que el equipo usa para trabajar con Claude en un Mac, con **una sola instalación que después se actualiza sola**.

## Instalar (o reparar)
Abre la app **Terminal** y pega:

```bash
curl -fsSL https://raw.githubusercontent.com/optimizo-cl/kit-claude/main/instalar.sh | bash
```

Instala o deja al día:
1. **Medula** (app de escritorio) en Aplicaciones. Después se actualiza sola.
2. **Claude Code**. Después se actualiza solo.
3. El **conector de Medula** para tu empresa.
4. El kit **paid-media**: método, comandos y conexión al cerebro de Paid Media. Se actualiza solo desde `main`.

Puedes volver a correrlo cuando quieras: lo que ya está al día no se toca.

## Primera vez (una sola vez)
1. Abre **Medula** desde Aplicaciones y entra con tu correo.
2. En Terminal escribe `claude`. Dentro, escribe `/mcp`:
   - `medula` → Autenticar → elige **tu empresa**.
   - `plugin:paid-media:paid-media` → Autenticar → elige la empresa **Paid Media**.

## Comandos del kit
| Comando | Qué hace |
|---|---|
| `/paid-media:brief <marca> <objetivo>` | Arma el brief de una campaña |
| `/paid-media:ideas <marca> <campaña> [n]` | Grilla de ideas y lote de tarjetas para elegir |
| `/paid-media:ficha <marca> <idea>` | Ficha completa, guion o arte, 3 inicios y textos 5-5-5 |
| `/paid-media:textos <marca> <pieza>` | 5 textos, 5 titulares y 5 descripciones |
| `/paid-media:informe <marca> <período>` | Lectura de resultados y decisiones propuestas |
| `/paid-media:aprender <marca> <feedback>` | Convierte feedback en reglas del cerebro (con tu aprobación) |

También funciona sin comandos: «hagamos anuncios de X para este mes» activa el método solo.

## Cómo se actualiza
- **Medula** revisa cada hora si hay versión nueva y se instala al cerrarla.
- **El kit** se actualiza solo cuando hay cambios en `main` de este repositorio.
- **El cerebro** vive en Medula: lo que se aprende queda disponible al instante para todo el equipo.
