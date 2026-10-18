---
name: add-paper
description: Add a new publication or update an existing one (e.g. preprint accepted to a venue, new workshop, award) in _bibliography/papers.bib. Use when the user asks to add/update a paper or publication.
---

# Add or update a paper

## Gather info
Usually the user gives an arXiv/ACL Anthology link. Fetch it to get the title, full author list, abstract, and year. Ask the user only for things you can't find:
- the venue and its badge text (`abbr`)
- whether it should be **selected** (shown on the home page)
- a preview figure (optional)
- any award

## Update vs. add
First search `papers.bib` by title or arXiv ID. If the paper is already there, for example as `"Under Review"` or as a preprint, **update that entry** rather than adding a duplicate. Typical updates are changing `journal`/`abbr`, adding `workshop`/`workshop_two` badges, or adding `award`.

## New entry template
Insert it at the **top** of `_bibliography/papers.bib`. The file runs newest-first, and the page groups entries by `year`.

```bibtex
@article{firstauthorlastname-YYYY-shortkeyword,
  title={Full Paper Title},
  author={First Last and Nishant Subramani and First Last},
  journal={ICML},
  year={2026},
  url={https://arxiv.org/abs/XXXX.XXXXX},
  bibtex_show = {true},
  abbr = "ICML",
  selected = {true},
  paper_link = {https://arxiv.org/abs/XXXX.XXXXX},
  preview = {short_name.png},
  abstract = {Abstract text, on one line.},
}
```

## Field rules
- **`url` and `paper_link`:** set both to the same link. The Paper button appears only when `url` is non-empty, but it links to `paper_link`.
- **`abbr`:** the main venue badge. Conventions:
  - main conference: `"ICML"`, `"ACL"`, `"COLM"`
  - Findings: still just `"EACL"` or `"EMNLP"`, with the `journal` saying "Findings of …"
  - workshop: `"COLM (SciFM)"`, `"ACL (TrustNLP)"`
  - not yet accepted: `"Under Review"`
- **`workshop`, `workshop_two`:** extra light-blue badges for other venues where the same paper also appeared, e.g. `workshop = {ICML (MechInterp)}`.
- **`award`:** renders as a 🏆 badge, e.g. `award = "Best Paper"`.
- **`selected = {true}`:** shows the paper on the home page. Leave it out, or set it to `{}`, to keep the paper off the home page.
- **`preview`:** a file name in `assets/img/publication_preview/`. If the user supplies an image, copy it there with a short snake_case name. Leave the field out if there's no image.
- **`author`:** use "First Last and First Last" format. Nishant is highlighted automatically.
- **Key:** `lastname-YYYY-keyword`, or `lastname-etal-YYYY-keyword` for 3 or more authors. It must be unique within the file.

## Afterwards
Offer to add a matching news item with the `add-news` skill.
