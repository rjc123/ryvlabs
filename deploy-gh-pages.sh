#!/bin/bash

set -e

echo "🚀 Deploying to GitHub Pages..."

cd client

if [ ! -d ".git" ]; then
    echo "❌ Error: Not a git repository. Please initialize git first."
    exit 1
fi

echo "📦 Building Hugo site..."
hugo --minify

echo "📤 Deploying to gh-pages branch..."

cd public

if [ ! -d ".git" ]; then
    git init
    git checkout -b gh-pages
else
    git checkout gh-pages
fi

git add -A

msg="Rebuild site $(date)"
if [ -n "$*" ]; then
    msg="$*"
fi

git commit -m "$msg"

echo "✅ Build complete! Now push with:"
echo "   cd client/public && git push origin gh-pages --force"
echo ""
echo "💡 Or set up your remote first:"
echo "   cd client/public && git remote add origin <your-repo-url>"
