---
name: add-news
description: Add a news item (talk, acceptance, award, preprint, internship, etc.) to the website's news feed in _news/. Use when the user asks to add/post news or an announcement.
---

# Add a news item

1. Get from the user (ask only for what's missing): the **date** (default: today), and **what happened** with any links (paper, venue, host group/person).
2. Create `_news/YYYY_MM_DD_short_slug.md` (lowercase snake_case slug, e.g. `2026_08_12_pavlicklab_talk.md`). The filename date must match the `date:` field.
3. Use exactly this format:

```markdown
---
layout: post
date: YYYY-MM-DD 00:00:00-1200
inline: true
related_posts: false
---

One or two sentences, single paragraph, with [markdown links](https://...) and optional emoji shortcodes like :tada:.
```

## Style (match existing items)

- First person, past tense, ends with `!`. E.g. `Gave a talk at Brown University in [Ellie Pavlick's group](...) on _Talk Title_!`
- Paper names are linked to arXiv/ACL Anthology; venues linked to the conference site; people linked to their homepages. Mentees: `led by my undergrad mentee [Name](https://...)`.
- Talk titles in `_italics_` (Prettier converts `*x*` to `_x_`).
- Single paragraph only (`<p>` tags get stripped in the feed).
- No trailing whitespace. Run `npx prettier --write <file>` on the new file before committing.

## If the news is a paper acceptance/preprint

Also check `_bibliography/papers.bib` — add the paper or update its venue (use the `add-paper` skill).
