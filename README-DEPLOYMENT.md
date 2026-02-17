# Deploying to GitHub Pages

This Hugo site can be deployed to GitHub Pages using the provided deployment script.

## Quick Start

1. **Make the script executable:**
   ```bash
   chmod +x deploy-gh-pages.sh
   ```

2. **Run the deployment script:**
   ```bash
   ./deploy-gh-pages.sh
   ```

3. **Set up your GitHub repository (first time only):**
   ```bash
   cd client/public
   git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPO.git
   git push origin gh-pages --force
   ```

4. **Enable GitHub Pages:**
   - Go to your GitHub repository settings
   - Navigate to "Pages" section
   - Set source to "gh-pages" branch
   - Your site will be available at: `https://YOUR-USERNAME.github.io/YOUR-REPO/`

## Subsequent Deployments

After the initial setup, just run:
```bash
./deploy-gh-pages.sh
cd client/public
git push origin gh-pages --force
```

## Using GitHub Actions (Alternative)

You can also automate deployment with GitHub Actions. Create `.github/workflows/deploy.yml`:

```yaml
name: Deploy Hugo site to GitHub Pages

on:
  push:
    branches: ["main"]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          submodules: recursive
          fetch-depth: 0
      
      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v2
        with:
          hugo-version: 'latest'
          extended: true
      
      - name: Build
        run: cd client && hugo --minify
      
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v2
        with:
          path: ./client/public

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v3
```

This will automatically deploy your site whenever you push to the main branch.

## Configuration

If deploying to a subdirectory (like `username.github.io/repo-name`), update `client/hugo.toml`:

```toml
baseURL = 'https://YOUR-USERNAME.github.io/YOUR-REPO/'
```

For a root domain (`username.github.io`):
```toml
baseURL = 'https://YOUR-USERNAME.github.io/'
```
