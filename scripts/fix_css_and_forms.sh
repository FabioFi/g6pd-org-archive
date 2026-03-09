#!/usr/bin/env bash
# fix_css_and_forms.sh
# 1. Inject CSS <link> tags into pages archived without them
# 2. Change method="post" -> method="get" on all forms (no live backend)
set -euo pipefail

BASE="$(cd "$(dirname "$0")/.." && pwd)"
DOCS="$BASE/docs"

CSS_BLOCK='<link href="/g6pd-org-archive/css/company.css" type="text/css" rel="stylesheet"/><link href="/g6pd-org-archive/css/Panelbar/style.css" type="text/css" rel="stylesheet"/><link href="/g6pd-org-archive/css/Tabstrip/styles.css" type="text/css" rel="stylesheet"/><link href="/g6pd-org-archive/css/print.css" type="text/css" rel="stylesheet" media="print"/><link href="/g6pd-org-archive/css/mobile.css" type="text/css" rel="stylesheet" media="only screen and (min-width: 240px) and (max-width: 480px)"/>'

echo "==> Step 1: Injecting CSS into pages missing stylesheets..."
find "$DOCS" -name "*.html" | while read -r f; do
  if ! grep -q 'rel="stylesheet"' "$f"; then
    sed -i "s|<base href=\"/g6pd-org-archive/\">|<base href=\"/g6pd-org-archive/\">\n${CSS_BLOCK}|" "$f"
    echo "  css injected: $(basename "$f")"
  fi
done

echo ""
echo "==> Step 2: Changing method=\"post\" to method=\"get\" on all forms..."
find "$DOCS" -name "*.html" | while read -r f; do
  if grep -q 'method="post"' "$f"; then
    sed -i 's/method="post"/method="get"/g' "$f"
    echo "  form fixed: $(basename "$f")"
  fi
done

echo ""
echo "==> Verification:"
echo -n "  Pages missing stylesheet: "
grep -rL 'rel="stylesheet"' "$DOCS" --include="*.html" | wc -l

echo -n "  Pages with method=post remaining: "
grep -rl 'method="post"' "$DOCS" --include="*.html" | wc -l

echo ""
echo "Done."
