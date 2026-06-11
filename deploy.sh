#!/bin/bash
# ============================================================
# OQ Social Investment Report 2025 (AR/EN) — GitHub Pages deployment
# Usage:  GH_TOKEN=ghp_xxxx ./deploy.sh [repo-name]
# ============================================================
set -e

REPO="${1:-oq-si-report-2025}"
[ -z "$GH_TOKEN" ] && { echo "ERROR: set GH_TOKEN first  ->  GH_TOKEN=ghp_xxx ./deploy.sh"; exit 1; }

API="https://api.github.com"
AUTH="Authorization: Bearer $GH_TOKEN"

echo "==> Verifying token..."
USER=$(curl -s -H "$AUTH" $API/user | python3 -c "import sys,json;print(json.load(sys.stdin).get('login',''))")
[ -z "$USER" ] && { echo "ERROR: invalid token"; exit 1; }
echo "    Authenticated as: $USER"

echo "==> Creating repository $USER/$REPO ..."
curl -s -o /dev/null -H "$AUTH" -X POST $API/user/repos \
  -d "{\"name\":\"$REPO\",\"private\":false,\"description\":\"OQ Group 2025 Social Investment Report — interactive bilingual HTML\"}" || true

echo "==> Pushing files..."
cd "$(dirname "$0")"
rm -rf .git
git init -q
git config user.email "deploy@oq.local"
git config user.name "Sulaiman Al-Rubaiai"
git add index.html assets README.md 2>/dev/null || git add index.html assets
git commit -qm "OQ Social Investment Report 2025 — bilingual interactive page (AR/EN)"
git branch -M main
git remote add origin "https://$USER:$GH_TOKEN@github.com/$USER/$REPO.git"
git push -qu origin main --force

echo "==> Enabling GitHub Pages..."
curl -s -o /dev/null -H "$AUTH" -X POST $API/repos/$USER/$REPO/pages \
  -d '{"source":{"branch":"main","path":"/"}}' || \
curl -s -o /dev/null -H "$AUTH" -X PUT $API/repos/$USER/$REPO/pages \
  -d '{"source":{"branch":"main","path":"/"}}' || true

echo ""
echo "============================================================"
echo "  DONE. The page will be live within 1-2 minutes at:"
echo "  https://$USER.github.io/$REPO/"
echo "============================================================"
echo "  Remember to DELETE the token from GitHub settings."
