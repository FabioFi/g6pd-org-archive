#!/usr/bin/env bash
set -euo pipefail

BASE="$(cd "$(dirname "$0")/.." && pwd)"
WEB="$BASE/web/20200528122801/https:/www.g6pd.org"
CSS_SRC="$BASE/web/20200528122801cs_/https:/www.g6pd.org"
IMG_SRC="$BASE/web/20200528122801im_/https:/www.g6pd.org"
JS_SRC="$BASE/web/20200528122801js_/https:/www.g6pd.org"

echo "==> Creating directory structure..."
mkdir -p "$BASE/docs/css/Panelbar" "$BASE/docs/css/Tabstrip"
mkdir -p "$BASE/docs/js"
mkdir -p "$BASE/docs/images/English" "$BASE/docs/images/HomeGallery" "$BASE/docs/images/theme"
mkdir -p "$BASE/docs/drugs"
mkdir -p "$BASE/docs/en/Community"
mkdir -p "$BASE/docs/en/G6PDDeficiency/SafeUnsafe"
mkdir -p "$BASE/docs/en/News/12-02-07"
mkdir -p "$BASE/docs/en/News/2012/12/17"
mkdir -p "$BASE/docs/en/News/2013/04/04"
mkdir -p "$BASE/docs/en/News/2014/05/10"
mkdir -p "$BASE/docs/en/News/2014/11/22"
mkdir -p "$BASE/docs/G6PDDeficiency"
mkdir -p "$BASE/data"

# ── HTML pages ──────────────────────────────────────────────────────────
echo "==> Copying HTML pages..."
cp "$WEB/index.html"                                         "$BASE/docs/index.html"
cp "$WEB/en/"*.html                                          "$BASE/docs/en/"
cp "$WEB/en/Community/"*.html                                "$BASE/docs/en/Community/"
cp "$WEB/en/G6PDDeficiency/"*.html                           "$BASE/docs/en/G6PDDeficiency/"
cp "$WEB/en/G6PDDeficiency/SafeUnsafe/drugs-official-list.html" "$BASE/docs/drugs/"
cp "$WEB/en/News/12-02-07/"*.html                            "$BASE/docs/en/News/12-02-07/"
cp "$WEB/en/News/2012/12/17/"*.html                          "$BASE/docs/en/News/2012/12/17/"
cp "$WEB/en/News/2013/04/04/"*.html                          "$BASE/docs/en/News/2013/04/04/"
cp "$WEB/en/News/2014/05/10/"*.html                          "$BASE/docs/en/News/2014/05/10/"
cp "$WEB/en/News/2014/11/22/"*.html                          "$BASE/docs/en/News/2014/11/22/"
cp "$WEB/G6PDDeficiency/"*.html                              "$BASE/docs/G6PDDeficiency/"

# MyFiles docs
mkdir -p "$BASE/data/MyFiles"
cp "$WEB/MyFiles/"*.doc                                      "$BASE/data/MyFiles/"

# ── CSS ─────────────────────────────────────────────────────────────────
echo "==> Copying CSS..."
cp "$CSS_SRC/App_Themes/Emerald-Blue/Panelbar/style.css"    "$BASE/docs/css/Panelbar/"
cp "$CSS_SRC/App_Themes/Emerald-Blue/Tabstrip/styles.css"   "$BASE/docs/css/Tabstrip/"
cp "$CSS_SRC/App_Themes/Emerald-Blue/company.css"           "$BASE/docs/css/"
cp "$CSS_SRC/MobileCss/mobile.css"                          "$BASE/docs/css/"
cp "$CSS_SRC/Print/print.css"                               "$BASE/docs/css/"

# ── Images ──────────────────────────────────────────────────────────────
echo "==> Copying images..."
cp "$IMG_SRC/App_Themes/Emerald-Blue/img/"*                 "$BASE/docs/images/theme/"
cp "$IMG_SRC/Images/English/"*                              "$BASE/docs/images/English/"
cp "$IMG_SRC/Images/HomeGallery/"*                          "$BASE/docs/images/HomeGallery/"
# root Images/
for f in "$IMG_SRC/Images/"*; do
  [[ -f "$f" ]] && cp "$f" "$BASE/docs/images/"
done

# ── JS ──────────────────────────────────────────────────────────────────
echo "==> Copying JS..."
cp "$JS_SRC/cookiechoices.js"                               "$BASE/docs/js/"
cp "$JS_SRC/App_Themes/Emerald-Blue/fontswitch.js"          "$BASE/docs/js/"

echo ""
echo "==> Done! New structure:"
find "$BASE/docs" -type f | sort
find "$BASE/data" -type f | sort
