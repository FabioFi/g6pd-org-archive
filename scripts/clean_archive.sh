#!/usr/bin/env bash

echo "Cleaning Wayback artifacts..."

# remove wayback toolbar scripts
find . -type f -name "*.html" -exec sed -i 's|https://web.archive.org/web/[0-9]*/||g' {} +

# remove archive banner code
find . -type f -name "*.html" -exec sed -i '/archive.org/d' {} +

# fix absolute domain links
find . -type f -name "*.html" -exec sed -i 's|https://www.g6pd.org|.|g' {} +

# convert absolute root links
find . -type f -name "*.html" -exec sed -i 's|href="/|href="./|g' {} +
find . -type f -name "*.html" -exec sed -i 's|src="/|src="./|g' {} +

echo "Done."