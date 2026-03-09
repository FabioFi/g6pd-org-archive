#!/usr/bin/env bash
# fix_asset_paths.sh
# Rewrites all Wayback Machine asset references in HTML files under docs/
# to use the new absolute /g6pd-org-archive/... paths.
set -euo pipefail

BASE="$(cd "$(dirname "$0")/.." && pwd)"
DOCS="$BASE/docs"

echo "==> Fixing asset paths in all HTML files under $DOCS ..."

# Process every HTML file
find "$DOCS" -name "*.html" | while read -r file; do
  echo "  $file"

  # ----- CSS ---------------------------------------------------------------
  # App_Themes main CSS (company.css, Panelbar, Tabstrip)
  sed -i 's|[./]*20200528122801cs_/https:/www\.g6pd\.org/App_Themes/Emerald-Blue/|/g6pd-org-archive/css/|g' "$file"

  # Print CSS
  sed -i 's|[./]*20200528122801cs_/https:/www\.g6pd\.org/Print/|/g6pd-org-archive/css/|g' "$file"

  # Mobile CSS
  sed -i 's|[./]*20200528122801cs_/https:/www\.g6pd\.org/MobileCss/|/g6pd-org-archive/css/|g' "$file"

  # Telerik combined bundle (axd – not a real file we have; just neutralise path)
  sed -i 's|[./]*20200528122801cs_/https:/www\.g6pd\.org/Telerik[^"]*|/g6pd-org-archive/css/company.css|g' "$file"

  # Any remaining css_ refs
  sed -i 's|[./]*20200528122801cs_/https:/www\.g6pd\.org/|/g6pd-org-archive/css/|g' "$file"

  # ----- Images ------------------------------------------------------------
  # Theme images
  sed -i 's|[./]*20200528122801im_/https:/www\.g6pd\.org/App_Themes/Emerald-Blue/img/|/g6pd-org-archive/images/theme/|g' "$file"

  # HomeGallery images
  sed -i 's|[./]*20200528122801im_/https:/www\.g6pd\.org/Images/HomeGallery/|/g6pd-org-archive/images/HomeGallery/|g' "$file"

  # English images
  sed -i 's|[./]*20200528122801im_/https:/www\.g6pd\.org/Images/English/|/g6pd-org-archive/images/English/|g' "$file"

  # Root Images/
  sed -i 's|[./]*20200528122801im_/https:/www\.g6pd\.org/Images/|/g6pd-org-archive/images/|g' "$file"

  # Any remaining im_ refs
  sed -i 's|[./]*20200528122801im_/https:/www\.g6pd\.org/|/g6pd-org-archive/images/|g' "$file"

  # ----- JS ----------------------------------------------------------------
  # fontswitch.js
  sed -i 's|[./]*20200528122801js_/https:/www\.g6pd\.org/App_Themes/Emerald-Blue/fontswitch\.js|/g6pd-org-archive/js/fontswitch.js|g' "$file"

  # cookiechoices.js
  sed -i 's|[./]*20200528122801js_/https:/www\.g6pd\.org/cookiechoices\.js|/g6pd-org-archive/js/cookiechoices.js|g' "$file"

  # ASP.NET Script/WebResource.axd – not available; point to a no-op
  sed -i 's|[./]*20200528122801js_/https:/www\.g6pd\.org/ScriptResource\.axd[^"]*|/g6pd-org-archive/js/fontswitch.js|g' "$file"
  sed -i 's|[./]*20200528122801js_/https:/www\.g6pd\.org/WebResource\.axd[^"]*|/g6pd-org-archive/js/fontswitch.js|g' "$file"

  # Any remaining js_ refs
  sed -i 's|[./]*20200528122801js_/https:/www\.g6pd\.org/|/g6pd-org-archive/js/|g' "$file"

done

echo ""
echo "==> Done. Verifying no wayback asset refs remain..."
REMAINING=$(grep -r '20200528122801[cij][sm]_' "$DOCS" --include="*.html" -l | wc -l)
if [[ "$REMAINING" -eq 0 ]]; then
  echo "    All clean!"
else
  echo "    WARNING: $REMAINING file(s) still contain wayback refs:"
  grep -r '20200528122801[cij][sm]_' "$DOCS" --include="*.html" -l
fi
