# GoBrandIt Chatwoot Maintenance Workflow

This repository follows a simple release flow so upstream Chatwoot upgrades and GoBrandIt-specific features stay easy to maintain.

## Branch roles

- `main`: deployable GoBrandIt branch. Production deploys should come from here.
- `feature/<name>`: short-lived feature branches created from `main`.
- `upgrade/chatwoot-vX.Y.Z` or `codex/upgrade-chatwoot-vX.Y.Z`: short-lived upstream upgrade branches created from `main`.

## Upstream Chatwoot upgrade flow

1. Fetch upstream tags from `chatwoot/chatwoot`.
2. Create an upgrade branch from `main`.
3. Merge the desired upstream release tag into the upgrade branch.
4. Resolve conflicts while preserving GoBrandIt branding and deployment customizations.
5. Validate the branch.
6. Merge the upgrade branch back into `main`.
7. Deploy `main`.

## GoBrandIt feature flow

1. Create `feature/<name>` from `main`.
2. Build and validate the feature.
3. Merge the feature branch back into `main`.
4. Deploy `main`.

## Deployment flow

Pushes to `main` publish a GHCR image through `.github/workflows/publish_gobrandit_ghcr.yml`.

Expected stable image tag:

- `ghcr.io/<owner>/chatbrandit:main`

Recommended server flow:

1. Pull the latest `main` branch on the server checkout.
2. Build the CE release image with `script/build_ce_release_image.sh`.
3. Update the server compose file to use the stable `chatbrandit:main` tag if needed.
4. Restart `rails` and `sidekiq`.
5. Verify `https://chat.gobrandit.app`.

## Guardrails

- Keep GoBrandIt customizations small and explicit.
- Prefer merging upstream releases into `main` instead of rebasing long-lived custom history.
- Avoid editing production directly when the same change should live in Git.
