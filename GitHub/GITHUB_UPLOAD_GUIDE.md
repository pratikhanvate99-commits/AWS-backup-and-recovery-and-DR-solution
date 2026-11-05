# GitHub Upload Guide

Step-by-step instructions to publish **AWS-Disaster-Recovery-Solution** safely.

> Nothing in this repository pushes to GitHub automatically. You run every command yourself.

## 1. Before you begin

1. Complete the placeholders you intend to publish (see the README "Information to fill in" list in the delivery notes).
2. Add real, **redacted** screenshots to [`../Screenshots/`](../Screenshots/README.md).
3. Complete the [pre-publish security checklist](../Documentation/08-security-best-practices.md#pre-publish-security-checklist).

## 2. Install and configure Git

```bash
git --version
git config --global user.name  "Prateek Hanvate"
git config --global user.email "<YOUR_GITHUB_NOREPLY_OR_EMAIL>"
```

Tip: use the GitHub no-reply email (Settings > Emails) to avoid exposing your personal address.

## 3. Create the GitHub repository

1. Sign in at github.com and click **New repository**.
2. Name: `AWS-Disaster-Recovery-Solution`.
3. Visibility: Public (for portfolio) or Private.
4. **Do not** tick "Add a README", ".gitignore" or "license" (they already exist locally).
5. Click **Create repository** and copy the URL.

## 4. Initialise and push

```bash
cd AWS-Disaster-Recovery-Solution
git init -b main
git add .
git status            # review exactly what will be committed
git ls-files          # confirm no secrets or unwanted files
git commit -m "Initial commit: AWS Disaster Recovery & Backup Solution documentation"
git remote add origin https://github.com/<YOUR_GITHUB_USERNAME>/AWS-Disaster-Recovery-Solution.git
git push -u origin main
```

Authentication: GitHub requires a **Personal Access Token** (HTTPS) or an **SSH key**; passwords are not accepted. Keep tokens and keys out of the repository.

## 5. Upload through the web interface (alternative)

1. Open the empty repository and choose **uploading an existing file**.
2. Drag the folder contents (not the ZIP file) into the page. Include the hidden `.github` and `.gitignore` entries; some browsers hide dotfiles, so Git is recommended.
3. Commit directly to `main`.

## 6. After publishing

1. **Settings > About**: add a description and topics such as `aws`, `disaster-recovery`, `backup`, `devops`, `cloud-computing`.
2. Check that Mermaid diagrams render in the README.
3. Open the **Actions** tab and confirm the quality-check workflow passes.
4. Enable **Settings > Code security**: secret scanning and push protection (where available).
5. Pin the repository on your GitHub profile.

## 7. Updating later

```bash
git add -A
git commit -m "docs: describe restore test results"
git push
```
