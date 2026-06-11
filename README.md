# OQ Group — 2025 Social Investment Report (Interactive, AR/EN)

Bilingual interactive HTML version of the OQ Group 2025 Social Investment Report.
A fixed toggle in the header switches between English (LTR) and Arabic (RTL); the
Download button serves the PDF matching the active language.

- `index.html` — the full interactive bilingual page (~4 MB)
- `assets/OQ_Social_Investment_Report_2025.pdf` — official English PDF
- `assets/OQ_Social_Investment_Report_2025_AR.pdf` — official Arabic PDF (approved SI_AR_v3)
- `assets/OQ_Sonic_Identity.mp3` — OQ sonic identity (background audio)

## Deploy to GitHub Pages (one command)

```bash
GH_TOKEN=ghp_xxxxxxxxxxxx ./deploy.sh oq-si-report-2025
```

The script creates the repository, pushes the files, and enables GitHub Pages.
Live URL: `https://<username>.github.io/oq-si-report-2025/`

> Delete the token from GitHub settings after deployment.
