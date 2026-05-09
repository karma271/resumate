# Resumate

A single-page resume built with [Typst](https://typst.app), using a customized `modern-cv` template. Outputs a clean PDF with accent colors, FontAwesome icons, and a two-column layout — all controlled from plain `.typ` files.

---

## Requirements

<details>
<summary><strong>Typst</strong></summary>

Install the Typst CLI via Homebrew or download from [typst.app](https://typst.app):

```sh
brew install typst
```

To compile to PDF:

```sh
typst compile resume.typ
```

To watch for changes and auto-recompile:

```sh
typst watch resume.typ
```

The recommended editor is VS Code with the [Typst Preview](https://marketplace.visualstudio.com/items?itemName=mgt19937.typst-preview) extension for live preview.

</details>

---

<details>
<summary><strong>Fonts</strong></summary>

Fonts are bundled in `assets/fonts/` — no system installation needed. The directory contains:

```
assets/fonts/
  HelveticaNeue.ttc
  Font Awesome 7 Free-Regular-400.otf
  Font Awesome 7 Free-Solid-900.otf
  Font Awesome 7 Brands-Regular-400.otf
```

The `.vscode/settings.json` points Typst Preview at this directory automatically.

**To use a different body font:** drop the `.ttf` or `.otf` file into `assets/fonts/`, then update the `font:` value searched by `font:` inside `#let resume(` in `template_modern_cv/lib.typ`.

</details>

---

<details>
<summary><strong>Profile Picture</strong></summary>

Profile picture support is built into the template but currently disabled (`profile-picture: none` in `resume.typ`).

To enable it:
1. Place your image at `assets/images/profile.png` (square crop recommended — it will be clipped to a circle).
2. In `resume.typ`, replace `profile-picture: none` with:

```typst
profile-picture: image("assets/images/profile.png")
```

</details>

---

## File Map

```
resume.typ                          ← personal info, section order
sections/
  summary.typ                       ← one-paragraph pitch
  skills.typ                        ← two-column skills grid
  experience.typ                    ← work history
  projects.typ                      ← side projects
  education.typ                     ← degrees / programs
  notable_accomplishments.typ       ← awards / wins
template_modern_cv/lib.typ          ← all styling, colors, fonts, spacing
assets/
  fonts/                            ← bundled font files
  images/                           ← profile picture (optional)
```

---

## Content Sections

<details>
<summary><strong>Personal Info</strong> — <code>resume.typ</code></summary>

Search for `resume.with(` — edit name, contact details, and the tagline shown under your name.

```typst
#show: resume.with(
  author: (
    firstname: "Prasoon",
    lastname: "Karmacharya",
    email: "pk425@cornell.edu",
    phone: "(+1) 607-319-1661",
    github: "karma271",
    linkedin: "karmacharya",
    positions: ("Data Scientist",)   // ← tagline; add more with commas
  ),
  ...
)
```

</details>

---

<details>
<summary><strong>Summary</strong> — <code>sections/summary.typ</code></summary>

Replace the prose inside the block. Plain text only; no bullets.

```typst
#resume-summary[
  Your one- or two-sentence pitch goes here.
]
```

</details>

---

<details>
<summary><strong>Skills</strong> — <code>sections/skills.typ</code></summary>

Skills are split into two columns. Left column: Languages / Tools / Cloud. Right column: Frameworks / Libraries.

**To add a skill:** append a string to the relevant `vals((...))` tuple.  
**To add a category:** add a new `cat("Name"),` + `vals((...)),` pair inside one of the two inner grids.

Pattern (one category row):
```typst
cat("Cloud"),
vals(("AWS", "Azure", "GCP", "Snowflake")),
```

To move a category between columns, cut the two-line pair from one inner `grid(...)` and paste it into the other.

</details>

---

<details>
<summary><strong>Experience</strong> — <code>sections/experience.typ</code></summary>

Each job is a pair of blocks — always edit/move/delete them together.

```typst
#resume-entry(
  title: "Job Title",
  description: "Company Name",
  location: "City or Remote",
  date: "Mon YYYY – Mon YYYY",
  inline-location: true,
)

#resume-item[
  - First bullet. Full sentences, specific numbers.
  - Second bullet.
]
```

**To add a job:** copy the pair, paste it before the first existing entry, fill in details.  
**To remove a job:** delete the `#resume-entry(...)` and the `#resume-item[...]` immediately after — both together.  
**To reorder:** move the pair as a unit. Entries render top-to-bottom in file order.

</details>

---

<details>
<summary><strong>Projects</strong> — <code>sections/projects.typ</code></summary>

Each project is a single block. Title, tech tag, and body flow inline.

```typst
#resume-project(title: "Project Name", description: "Tech / Category")[
  One or two sentences describing what you built and the outcome.
]
```

**To add a project:** copy a block and edit it.  
**To reorder:** move the block.

</details>

---

<details>
<summary><strong>Education</strong> — <code>sections/education.typ</code></summary>

```typst
#edu-entry("Degree or Program", "Year", "City, State")
#edu-entry("Institution", "Year", "City, State", description: "Field, Degree type")
```

`description` is optional — it renders as a lighter line below the title. Omit it for short entries like bootcamps.

</details>

---

<details>
<summary><strong>Notable Accomplishments</strong> — <code>sections/notable_accomplishments.typ</code></summary>

Each line is a `#block`. Use `*bold*` for the award name or rank.

```typst
#block(above: 0.5em, below: 0pt)[*Award name* brief context]
```

**To add:** copy any `#block(...)` line and edit it.  
**To remove:** delete the line.

</details>

---

## Formatting Changes

All global formatting lives in **`template_modern_cv/lib.typ`**.  
Section-level overrides are passed as arguments to `resume.with(...)` in `resume.typ`.

<details>
<summary><strong>Colors</strong></summary>

| What | Search for in `lib.typ` | Current value |
|---|---|---|
| Accent (headers, icons, dates) | `default-accent-color` | `rgb("#7789DA")` |
| Sub-accent (pipes, sub-text) | `default-sub-accent-color` | `rgb("#71797E")` |
| Body text | `color-darkgray` | `rgb("#333333")` |
| Dark text (bullets, summary) | `color-darknight` | `rgb("#131A28")` |

To change the accent color globally, edit `default-accent-color`. To override for a single entry, pass `accent-color:` to that `resume-entry()` call.

</details>

---

<details>
<summary><strong>Fonts</strong></summary>

| What | Search for in `lib.typ` | Current value |
|---|---|---|
| Body font | `font:` inside `#let resume(` | `("Helvetica Neue", "Helvetica")` |
| Header font (name block) | `header-font:` inside `#let resume(` | `"Gill Sans"` |

The font list is a fallback chain — first available font on the system wins.

</details>

---

<details>
<summary><strong>Text Sizes</strong></summary>

| Element | Search for in `lib.typ` | Size |
|---|---|---|
| Base body text | `set text(` inside `#let resume(` | `8pt` |
| Summary paragraph | `#let resume-summary` | `9.5pt` |
| Section headings (`= SECTION`) | `show heading.where(level: 1)` | `12pt` |
| Entry title (job/project) | `show heading.where(level: 2)` | `9pt` |
| Entry date / location | `#let resume-entry` → `right-content` block | `9pt` |

</details>

---

<details>
<summary><strong>Spacing</strong></summary>

| What | Search for in `lib.typ` | Controls |
|---|---|---|
| Space above section headings | `show heading.where(level: 1)` | `above: 1.2em` |
| Space between paragraphs | `set par(spacing` | `0.75em` |
| Space above each entry header | `#let resume-entry` → opening `block(` | `above: 1em, below: 0.65em` |
| Space above bullet list | `#let resume-item` → `set block(` | `above: 0.75em, below: 0.75em` |
| Page margins | `set page(` inside `#let resume(` | `left/right: 8.5mm`, `top: 7mm`, `bottom: 8mm` |

</details>

---

<details>
<summary><strong>Section Order</strong></summary>

Sections render in the order they are `#include`-d in `resume.typ`. To reorder, move the `#include` lines. The two-column bottom block (education + accomplishments) is inside the `#block(above: 1.5em)` grid at the bottom of `resume.typ` — keep both includes together if you want them side-by-side.

</details>

---

## TODO

- [ ] **Cover letter** — `template_modern_cv/lib.typ` already contains a full `#let coverletter(...)` function (search for `#let coverletter(`). Create `coverletter.typ` at the project root mirroring the structure of `resume.typ`, and add a `sections/coverletter_body.typ` for the letter content. The template supports salutation, body paragraphs, signature, and a closing line referencing the attached CV.
