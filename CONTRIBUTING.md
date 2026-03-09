# Contributing

Thank you for your interest in improving this archive of the G6PD Deficiency Association website.

## Repository layout

```
docs/        ← GitHub Pages root (HTML, CSS, JS, images)
  css/       ← Stylesheets from the original site
  js/        ← JavaScript from the original site
  images/    ← All images (theme, gallery, logos)
  drugs/     ← Drug safety pages
  en/        ← English-language pages (mirrors original URL structure)
  G6PDDeficiency/ ← Root-level G6PD deficiency pages

data/
  drugs.json ← Machine-readable drug safety data (extracted from docs/drugs/)
  MyFiles/   ← Original downloadable documents

scripts/     ← Utility scripts
```

## How to contribute

1. **Fix broken links** – The pages were captured from the Wayback Machine. Internal
   links may still point to old absolute URLs. PRs that update them to relative
   paths are very welcome.

2. **Improve `data/drugs.json`** – Extract structured drug-safety records from
   `docs/drugs/drugs-official-list.html` and add them as JSON objects.

3. **Translations / additional pages** – If you have archived pages in other
   languages, open an issue first so we can agree on the directory layout.

## Submitting a pull request

```bash
git checkout -b fix/your-description
# make your changes
git commit -m "fix: short description"
git push origin fix/your-description
```

Then open a PR against `main`.

## Code of conduct

Be respectful. Medical information must be accurate – cite sources when adding
or changing drug safety data.
