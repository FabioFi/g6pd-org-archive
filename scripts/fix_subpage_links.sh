#!/usr/bin/env bash
# fix_subpage_links.sh
# 1. Inject <base href="/g6pd-org-archive/"> into every page that lacks it
# 2. Rewrite relative .aspx links -> .aspx.html  (skips http/https external links)
# 3. Copy drugs-official-list.html to its expected URL location
# 4. Create docs/en/G6PDDeficiency/SafeUnsafe.aspx.html
set -euo pipefail

BASE="$(cd "$(dirname "$0")/.." && pwd)"
DOCS="$BASE/docs"

echo "==> Step 1: Inject <base href> into pages missing it..."
find "$DOCS" -name "*.html" | while read -r f; do
  if ! grep -q '<base href' "$f"; then
    # Inject right after the Wayback closing comment (present in all archived pages)
    sed -i 's|<!-- End Wayback Rewrite JS Include -->|<!-- End Wayback Rewrite JS Include -->\n<base href="/g6pd-org-archive/">|' "$f"
    echo "  injected: $f"
  fi
done

echo ""
echo "==> Step 2: Rewrite relative .aspx links -> .aspx.html (skip http/https)..."
# Match href="..." or src="..." that:
#   - do NOT start with http or https (external links untouched)
#   - end with .aspx" or .aspx'
find "$DOCS" -name "*.html" | while read -r f; do
  # Double-quoted hrefs/srcs that are relative (not starting with http)
  # Perl lets us use negative lookahead: (?!https?://) after the opening quote
  perl -i \
    -e 's{((?:href|src|action)=")(?!https?://)([^"]*?)\.aspx(")}{$1$2.aspx.html$3}g;' \
    -e 's{((?:href|src|action)='"'"')(?!https?://)([^'"'"']*?)\.aspx('"'"')}{$1$2.aspx.html$3}g;' \
    "$f"
done

echo ""
echo "==> Step 3: Copy drugs-official-list to SafeUnsafe/ URL location..."
mkdir -p "$DOCS/en/G6PDDeficiency/SafeUnsafe"
cp "$DOCS/drugs/drugs-official-list.html" "$DOCS/en/G6PDDeficiency/SafeUnsafe/drugs-official-list.html"
echo "  created: docs/en/G6PDDeficiency/SafeUnsafe/drugs-official-list.html"

echo ""
echo "==> Step 4: Create en/G6PDDeficiency/SafeUnsafe.aspx.html..."
# Use the root-level archived version
cp "$DOCS/G6PDDeficiency/SafeUnsafe.aspx.html" "$DOCS/en/G6PDDeficiency/SafeUnsafe.aspx.html"
echo "  created: docs/en/G6PDDeficiency/SafeUnsafe.aspx.html"

echo ""
echo "==> Verification – pages still missing <base href>:"
grep -rL '<base href' "$DOCS" --include="*.html" || echo "  (none)"

echo ""
echo "==> Verification – any remaining unqualified .aspx\" refs (not .aspx.html\"):"
grep -r '\.aspx"' "$DOCS" --include="*.html" | grep -v '\.aspx\.html"' | grep -v 'http' | head -10 || echo "  (none)"

echo ""
echo "Done."
