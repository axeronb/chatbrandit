# CE Admin Account Controls

This custom layer adds Community Edition safe account controls to the Super Admin account edit screen without enabling Enterprise-only code paths.

## What it manages

- `status`
- per-account `agents` and `inboxes` limits
- CE-safe account feature toggles

## What it does not manage

- Enterprise-only billing or plan logic
- premium/internal/deprecated feature flags
- repo-root `enterprise/` code paths

## Implementation notes

- The UI lives under `app/fields/ce_account_*` and `app/views/fields/ce_account_*`.
- The account dashboard only shows these fields when `ChatwootApp.enterprise?` is false.
- Limits updates preserve unknown keys already stored in `accounts.limits` so future upstream changes are less risky.
- Feature updates only touch the CE-safe editable subset and leave premium/internal flags alone.

## Upgrade notes

When upgrading Chatwoot:

1. Re-check `app/dashboards/account_dashboard.rb` for upstream dashboard changes.
2. Re-check `app/controllers/super_admin/accounts_controller.rb` for parameter handling changes.
3. Re-check `app/models/account.rb` for limit handling or feature flag changes.
4. Keep new admin-only code in `app/`, not `enterprise/`.
