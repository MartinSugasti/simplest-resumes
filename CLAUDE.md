# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Simplest Resumes — a Rails 7.2 / Ruby 3.4 app where recruiters post jobs and search candidates, candidates build resumes and apply to jobs, and admins manage the platform. Rails serves ERB shells that mount React components for interactive UI; Devise handles auth for three separate user types. Live at https://simplestresumes.com/.

## Commands

### Setup / running
- `bin/setup` — install deps, prepare db
- `bin/dev` — runs `web` (Rails server), `js` (esbuild --watch), `css` (sass --watch) via Foreman/Procfile.dev
- `yarn build` — one-off JS bundle (esbuild)
- `yarn build:css` — one-off CSS build (sass + autoprefixer)

### Tests
- `bundle exec rspec` — full suite
- `bundle exec rspec spec/models/resume_spec.rb` — single file
- `bundle exec rspec spec/models/resume_spec.rb:42` — single example by line
- CI (`.github/workflows/rspec.yml`) runs `bin/rails db:prepare` then `bundle exec rspec` against Postgres on every PR/push to main.

### Linting
- `bundle exec rubocop` — Ruby style (config in `.rubocop.yml`, legacy exceptions in `.rubocop_todo.yml`)
- `bundle exec erblint --lint-all` — ERB templates (`.erb-lint.yml`, delegates to the same Rubocop config)
- `yarn lint` — ESLint on `app/javascript` (Airbnb config)

## Architecture

### Three-role structure, mirrored everywhere
The app has three independent Devise-authenticated user models — `Admin`, `Candidate`, `Recruiter` (no STI; separate tables, separate `devise_for` blocks in `config/routes.rb`, grouped as `devise_group :user`). This split cascades through nearly every layer:
- `app/controllers/{admins,candidates,recruiters}/` — namespaced controllers, one tree per role
- `app/policies/{admins,candidates,recruiters}/` — Pundit policies scoped per role (`ApplicationPolicy` is the base; `authorize([:candidates, resume])` style namespaced authorization)
- `app/views/layouts/{admins,candidates,recruiters}/_sidebar.html.erb` — per-role dashboard chrome, composed via `app/views/layouts/shared/_dashboard.html.erb` and `_sidebar_container.html.erb`
- `app/javascript/components/{admins,candidates,recruiters}/` and `app/javascript/controllers/{admins,candidates,recruiters}/` — per-role React components and their mounting Stimulus controllers
- `config/routes.rb` — `namespace :admins|:candidates|:recruiters` blocks with a `dashboard/show` root per role
- Admins can masquerade as candidates/recruiters (`devise_masquerade`, `admins/masquerades_controller.rb`)

When adding a feature scoped to one role, follow the existing sibling role's file layout across all of these locations rather than inventing a new pattern.

### Rails + React integration (per-page, not SPA)
Each interactive page is a small React app, not one global SPA:
1. An ERB view renders a bare container `div` with a `data-controller` attribute (Stimulus), e.g. `app/views/candidates/my_resume/show.html.erb`.
2. The matching Stimulus controller in `app/javascript/controllers/<role>/` mounts the React root into that div.
3. The React component tree lives in `app/javascript/components/<role>/<feature>/`, typically with `index.js` (default export), a top-level `.jsx` component, `api.js` (axios calls via `shared/configuredAxios`), and sometimes `store/` (Redux, only where state is genuinely shared) and `routes/` (React Router, for multi-view features like job postings).
4. Controllers respond to both `format.html` (renders the ERB shell) and `format.json` (data for the React component), following Rails JSON API conventions — see `app/controllers/candidates/my_resume_controller.rb` as a reference.

Serialization to JSON goes through `app/serializers/*_serializer.rb` (ActiveModelSerializers), one per model, not ad hoc `as_json`/`to_json` in controllers.

### Resume domain model
`Resume` (`app/models/resume.rb`) belongs to `Candidate` and has several capped-length child collections (education, work experience, external links) plus two collections split by a `kind` enum on a single table: `SkillItem` (primary/secondary) and `ReferenceItem` (personal/job), exposed via scoped `has_many` associations (`primary_skill_items`, `job_reference_items`, etc.). When touching resume items, check `app/validators/resume_associations_count_validator.rb` for the shared max-count validation logic.

### Background jobs & scheduling
Sidekiq (+ `sidekiq-scheduler` for cron-style jobs, `sidekiq-failures` for dead-job tracking) under `app/jobs/{admins,candidates}/`. Sidekiq Web UI is mounted at `admins/sidekiq`, restricted to `admin.super_admin?`.

### External integrations
Each third-party integration lives under `app/services/<provider>/`:
- `open_ai/` — natural-language-to-SQL search (`NaturalLanguageToSqlService` and role-specific subclasses `CandidatesSqlService`, `JobPostingsSqlService`). This constructs and executes AI-generated SQL against Postgres — the service enforces a `SELECT`-only allowlist of keywords before execution; preserve that safety check if you modify it.
- `twilio/` — SMS notifications (e.g., on job application approval)
- `google/` — reCAPTCHA verification
- Stripe webhooks are handled directly in `app/controllers/stripe_webhooks_controller.rb`, not under `services/`.

### Auth details
- Devise handles standard auth per role; `devise_invitable` for admin invitations; `devise-two-factor` (OTP) for admins only.
- OmniAuth (GitHub, Google, Twitter) is shared across candidates and recruiters via a single `omniauth_callbacks_controller.rb`, dispatched by `devise_scope`.
- Authorization is Pundit throughout — controllers call `authorize`/`policy_scope`, failures are rescued in `ApplicationController#user_not_authorized` (flash + redirect for HTML, 401 JSON for API).

### i18n
English and Spanish locale files in `config/locales/`, split by domain (`devise.*.yml`, `pages.*.yml`, `rails_i18n.*.yml`, `es.yml`/`en.yml`). Locale is resolved per-request in `ApplicationController#set_locale` (signed-in user's `preferred_language` → `?lang=` param → `Accept-Language` header → default). The `i18n-js` gem exports these same YAML files to a frontend `translations.json` consumed by `react-i18next`, so backend and frontend translations should stay in the same locale files rather than duplicating strings in JS.

### Error monitoring
Honeybadger is used for exception tracking — notable rescued exceptions (invalid CSRF token, Pundit authorization failures, failed OpenAI SQL generation) are explicitly reported via `Honeybadger.notify` even when handled gracefully for the user; follow that pattern for new rescued exceptions that indicate a real problem.
