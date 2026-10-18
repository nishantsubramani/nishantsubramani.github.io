# CLAUDE.md

Personal academic site for Nishant Subramani (CMU LTI PhD, interpretability), served at https://nishantsubramani.github.io. It's a Jekyll site built from the [al-folio](https://github.com/alshedivat/al-folio) theme. A big refactor in Aug 2026 removed the template's unused demo content (blog, projects, teaching, repositories, etc.).

## What's live

| URL              | Source                             | Notes                                                                                          |
| ---------------- | ---------------------------------- | ---------------------------------------------------------------------------------------------- |
| `/`              | `_pages/about.md` (layout `about`) | Bio, profile photo, news feed, selected papers, social icons                                   |
| `/publications/` | `_pages/publications.md`           | Renders all of `_bibliography/papers.bib` via jekyll-scholar, grouped by year, with bib search |
| `/news/`         | `_pages/news.md`                   | Full news list, not in the navbar                                                              |
| `/cv/`           | `_pages/cv.md`                     | `layout: null` meta-refresh redirect to `assets/pdf/nishantsubramani_cv.pdf`                   |
| `/404.html`      | `_pages/404.md`                    |                                                                                                |

The navbar shows only pages with `nav: true`, ordered by `nav_order`: publications (2) and cv (5), plus "about" as home.

## Common edits

### Add a news item

Use the `add-news` skill (`.claude/skills/add-news/`). Create `_news/YYYY_MM_DD_slug.md`; every file follows this naming. The filename date must match the `date` field, which controls the sort order.

```markdown
---
layout: post
date: 2026-08-12 00:00:00-1200
inline: true
related_posts: false
---

One-line announcement with [links](https://...) and :emoji_shortcodes:.
```

- `inline: true` renders the body directly in the news table. Keep the body to one paragraph because `<p>` tags get stripped.
- The home page shows the 10 most recent items (`announcements.limit` in `_config.yml`).
- Emoji shortcodes (`:sunny:`) are rendered by jemoji. `_plugins/strip-emoji-shortcodes.rb` strips them for the search index because they used to break the generated JS.

### Add or update a publication

Use the `add-paper` skill (`.claude/skills/add-paper/`). Edit `_bibliography/papers.bib` and put the newest entries at the top. Entries use `@article` or `@inproceedings`. These fields matter (rendered by `_layouts/bib.liquid`):

- `abbr`: the venue badge, e.g. `"ICML"` or `"COLM (SciFM)"`. It can optionally be keyed in `_data/venues.yml` for a color or URL, but that file is currently empty.
- `workshop`, `workshop_two`: **custom** extra light-blue badges for additional venues.
- `award`: **custom** 🏆 badge. `extendedabstract`: **custom** plain badge.
- `paper_link`: **custom**. The "Paper" button appears only if `url` is non-empty, but it links to `paper_link`. Set both.
- `preview`: image file name in `assets/img/publication_preview/`.
- `selected = {true}`: shows the paper in "selected publications" on the home page.
- `bibtex_show = {true}`: shows the Bib button. `abstract`: shows the Abs button.
- Fields listed in `filtered_bibtex_keywords` (`_config.yml`) are hidden from the displayed BibTeX.
- Author highlighting uses `scholar.last_name` and `first_name` in `_config.yml`. Co-author links can go in `_data/coauthors.yml`.

### Update the CV

Replace `assets/pdf/nishantsubramani_cv.pdf` and keep the same file name.

### Bio, profile, and social links

- Bio text and subtitle: `_pages/about.md`. Photo: `assets/img/prof_pic.jpg`. Favicon: `prof_pic_color.jpg`.
- Social IDs (Scholar, Semantic Scholar, GitHub, LinkedIn, X, Bluesky) and `contact_note`: `_config.yml`.

## Structure

- `_config.yml`: all site settings, feature flags (`enable_*`), plugins, scholar config, and third-party library versions. Changes require restarting the server.
- `_layouts/`, `_includes/`: Liquid templates, mostly stock al-folio. Customized files: `_layouts/bib.liquid` (custom bibtex fields) and `_includes/scripts/search.liquid` (jsonify and emoji fixes).
- `_plugins/`: Ruby plugins. `strip-emoji-shortcodes.rb` is custom; the rest come from al-folio.
- `_sass/`: styles. Theme colors are in `_variables.scss` and `_themes.scss`. The entry point is `assets/css/main.scss`.
- `_data/`: `coauthors.yml`, `venues.yml`, `repositories.yml`.
- Leftover template layouts and includes (distill, post archives, cv/resume, projects, repositories) are unused but harmless. Blog-related plugins are commented out in `_config.yml`.
- `CUSTOMIZE.md`, `INSTALL.md`, `FAQ.md`, and `README.md` are al-folio upstream docs and are excluded from the build.

## Build, run, and deploy

- **Local:** the system Ruby is 2.6, which is too old (CI uses 3.2.2), so use Docker: `docker compose up` and open `http://localhost:8080`. The build output goes to `_site/`, which is gitignored.
- **Deploy:** pushing to `main` triggers `.github/workflows/deploy.yml`. It runs `bundle exec jekyll build` with Ruby 3.2.2, purges CSS, then pushes `_site` to the `gh-pages` branch. Don't edit `gh-pages` directly.
- After deploy, `broken-links-site.yml` runs lychee on local links. `broken-links.yml` checks links in the source on push.
- **Formatting:** Prettier with the Liquid plugin (`.prettierrc`, printWidth 150). Versions are pinned exactly in `package.json`/`package-lock.json`, and CI (`prettier.yml`) runs `npm ci` then `npx prettier . --check`. Locally, run `npm ci` once, then `npx prettier --write <files>` on changed files before committing. Bump both versions together in `package.json` if upgrading.
- **Link check:** `broken-links.yml` runs lychee on all `.md` and `.html` sources. Write placeholder or local URLs inside backticks so they are not checked. LinkedIn and GeekWire block bots, so they are excluded.

## Conventions

- Commit messages are short and lowercase (e.g. "added talks", "updated cv").
- Images in `assets/img/` get responsive WebP variants through jekyll-imagemagick. Reference images by file name; no manual resizing is needed.
