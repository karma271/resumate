# Resumate

A resume and cover letter built with [Typst](https://typst.app). Both share a centered header (name, tagline, contact icons) driven from the same author fields, and are compiled to separate PDFs from plain `.typ` files.

---

## Requirements

<details>
<summary><strong>Typst</strong></summary>

Install via Homebrew or download from [typst.app](https://typst.app):

```sh
brew install typst
```

Compile to PDF:

```sh
typst compile resume.typ
typst compile coverletter.typ
```

Watch and auto-recompile on save:

```sh
typst watch resume.typ
typst watch coverletter.typ
```

The recommended editor is VS Code with the [Typst Preview](https://marketplace.visualstudio.com/items?itemName=mgt19937.typst-preview) extension for live preview.

</details>

---

<details>
<summary><strong>Fonts</strong></summary>

Fonts are bundled in `assets/fonts/` — no system installation needed:

```
assets/fonts/
  HelveticaNeue.ttc
  Font Awesome 7 Free-Regular-400.otf
  Font Awesome 7 Free-Solid-900.otf
  Font Awesome 7 Brands-Regular-400.otf
```

The `.vscode/settings.json` points Typst Preview at this directory automatically. To add a different font, drop the `.ttf` or `.otf` file into `assets/fonts/`.

</details>

---

## File Map

```
resume.typ                        ← personal info, section includes
coverletter.typ                   ← author info, job target, letter body
sections/
  summary.typ
  skills.typ
  experience.typ
  projects.typ
  education.typ
  notable_accomplishments.typ
lib/
  lib_common.typ                  ← colors, icons, shared header function
  lib_resume.typ                  ← resume() template + resume-* components
  lib_coverletter.typ             ← coverletter() template + letter helpers
  lang.toml                       ← i18n strings
assets/
  fonts/                          ← bundled font files
  images/                         ← profile picture (optional)
```

---

## Shared

Both documents use the same color palette, font stack, and author field names — all defined in `lib/lib_common.typ`. The centered header (name → tagline → contact icons → separator line) is rendered by `centered-author-header()` from that file.

<details>
<summary><strong>Author Info</strong></summary>

**Resume** — edit inside `resume.with(author: ...)` in `resume.typ`:

```typst
#show: resume.with(
  author: (
    firstname:  "Prasoon",
    lastname:   "Karmacharya",
    email:      "pk425@cornell.edu",
    phone:      "(+1) 607-319-1661",
    github:     "karma271",
    linkedin:   "karmacharya",
    positions:  ("Data Scientist",)   // tagline shown under the name
  ),
  ...
)
```

**Cover Letter** — edit the `cl-author` dict at the top of `coverletter.typ`. Same field names, same header output.

Optional fields (add to either dict): `address`, `homepage`, `twitter`, `linkedin`, `gitlab`, `orcid`, `scholar`, `birth`.

</details>

---

<details>
<summary><strong>Colors</strong></summary>

All color variables live in `lib/lib_common.typ`:

| Variable | Current value | Used for |
|---|---|---|
| `default-accent-color` | `rgb("#7789DA")` | headers, icons, dates, company name |
| `default-sub-accent-color` | `rgb("#71797E")` | positions tagline, sub-text |
| `color-darkgray` | `rgb("#333333")` | body text |
| `color-darknight` | `rgb("#131A28")` | bullets, summary, letter body |

To change the accent globally, edit `default-accent-color`. To override for a single resume entry, pass `accent-color:` to that `resume-entry()` call.

</details>

---

<details>
<summary><strong>Fonts</strong></summary>

| What | Default | Where to override |
|---|---|---|
| Body font | `("Helvetica Neue", "Helvetica")` | `font:` param in `resume.with(...)` or `set text(font: ...)` in `coverletter.typ` |
| Header font (name block) | `"Gill Sans"` | `header-font:` param in `resume.with(...)` or `centered-author-header(...)` in `coverletter.typ` |

The font list is a fallback chain — the first font found on the system wins.

</details>

---

<details>
<summary><strong>Profile Picture</strong></summary>

Both documents support a profile photo, currently disabled (`profile-picture: none`).

To enable for the **resume**, replace `profile-picture: none` in `resume.typ`:

```typst
profile-picture: image("assets/images/profile.png")
```

Square crop recommended — it is clipped to a circle and placed to the right of the header.

The cover letter uses the shared `centered-author-header()` which does not show a photo. If you want a photo on the cover letter, switch its `#show:` rule to `coverletter.with(...)` from `lib/lib_coverletter.typ`, which has a photo-grid layout.

</details>

---

<details>
<summary><strong>Resume</strong></summary>

### Content

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

**To add a skill:** append a string to the relevant tuple.  
**To add a category:** add a `cat("Name"),` + `vals((...)),` pair inside the appropriate inner grid.

```typst
cat("Cloud"),
vals(("AWS", "Azure", "GCP", "Snowflake")),
```

To move a category between columns, cut the two-line pair and paste it into the other inner `grid(...)`.

</details>

---

<details>
<summary><strong>Experience</strong> — <code>sections/experience.typ</code></summary>

Each job is an entry + item pair — always edit, move, or delete them together.

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

**To add:** copy the pair, paste it before the first existing entry, fill in details.  
**To remove:** delete both the `resume-entry` and the `resume-item` immediately after.  
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

**To add:** copy a block and edit it. **To reorder:** move the block.

</details>

---

<details>
<summary><strong>Education</strong> — <code>sections/education.typ</code></summary>

```typst
#edu-entry("Degree or Program", "Year", "City, State")
#edu-entry("Institution", "Year", "City, State", description: "Field, Degree type")
```

`description` is optional — renders as a lighter line below the title. Omit it for short entries like bootcamps.

</details>

---

<details>
<summary><strong>Notable Accomplishments</strong> — <code>sections/notable_accomplishments.typ</code></summary>

Each line is a `#block`. Use `*bold*` for the award name or rank.

```typst
#block(above: 0.5em, below: 0pt)[*Award name* — brief context]
```

**To add:** copy any `#block(...)` line and edit it. **To remove:** delete the line.

</details>

---

### Formatting

<details>
<summary><strong>Section Order</strong></summary>

Sections render in the order they are `#include`-d in `resume.typ`. To reorder, move the `#include` lines.

The two-column bottom block (education + accomplishments) is inside the `grid(...)` near the bottom of `resume.typ` — keep both `include` lines together to preserve the side-by-side layout.

</details>

---

<details>
<summary><strong>Text Sizes</strong></summary>

All size values are in `lib/lib_resume.typ`:

| Element | Search for | Size |
|---|---|---|
| Base body text | `set text(` inside `#let resume(` | `8pt` |
| Summary paragraph | `#let resume-summary` | `9.5pt` |
| Section headings | `show heading.where(level: 1)` | `12pt` |
| Entry title | `show heading.where(level: 2)` | `9pt` |
| Entry date / location | `#let resume-entry` | `9pt` |

</details>

---

<details>
<summary><strong>Spacing</strong></summary>

All spacing values are in `lib/lib_resume.typ`:

| What | Search for | Value |
|---|---|---|
| Space above section headings | `show heading.where(level: 1)` | `above: 1.2em` |
| Space between paragraphs | `set par(spacing` | `0.75em` |
| Space above each entry | `#let resume-entry` → opening `block(` | `above: 1em, below: 0.65em` |
| Space above bullet list | `#let resume-item` → `set block(` | `above: 0.75em` |
| Page margins | `set page(` inside `#let resume(` | `left/right: 8.5mm`, `top: 7mm`, `bottom: 8mm` |

</details>

</details>

---

<details>
<summary><strong>Cover Letter</strong></summary>

The cover letter reuses the exact same centered header as the resume via `centered-author-header()` from `lib/lib_common.typ`. Everything below the header lives directly in `coverletter.typ` — no separate sections directory.

### Content

<details>
<summary><strong>Targeting a Job</strong></summary>

Four variables at the top of `coverletter.typ` control the job-specific block:

```typst
#let cl-company    = "MOONSHOT PROJECT"          // shown bold in accent color
#let cl-job-title  = "Principal Data Scientist"
#let cl-job-id     = "XYZ"                       // set to "" to omit (ID: ...)
#let cl-salutation = "Dear Hiring Manager,"
```

The `Re:` line is assembled automatically: `Re: [cl-job-title] (ID: [cl-job-id])`. If `cl-job-id` is `""`, the ID part is dropped.

</details>

---

<details>
<summary><strong>Body & Closing</strong></summary>

Body paragraphs are plain prose inside the `#pad(x: 6mm)[...]` block in `coverletter.typ`. Separate paragraphs with a blank line.

The closing is at the bottom of the same block:

```typst
#v(3em)
Sincerely,

#text(weight: "bold")[Prasoon Karmacharya]
```

To change the sign-off name, edit the `#text(weight: "bold")[...]` line.

</details>

---

### Formatting

<details>
<summary><strong>Page & Text Settings</strong></summary>

Set via Typst `set` rules at the top of `coverletter.typ`:

| What | Rule | Current value |
|---|---|---|
| Paper size | `set page(paper: ...)` | `"us-letter"` |
| Page margins | `set page(margin: ...)` | `left/right: 8.5mm`, `top: 7mm`, `bottom: 8mm` |
| Base text size | `set text(size: ...)` | `9pt` |
| Body paragraph size | `set text(size: 10pt, ...)` inside the pad block | `10pt` |
| Paragraph spacing | `set par(spacing: ...)` | `1.25em` |

</details>

</details>
