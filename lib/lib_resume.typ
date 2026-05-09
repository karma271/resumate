#import "lib_common.typ": *

// ── Internal footer ───────────────────────────────────────────────────────────

#let __resume_footer(author, language, date, use-smallcaps: true) = {
  set text(fill: gray, size: 8pt)
  __justify_align_3[
    #__apply_smallcaps(date, use-smallcaps)
  ][
    #__apply_smallcaps(
      {
        let name = __format_author_name(author, language)
        name + " · Résumé"
      },
      use-smallcaps,
    )
  ][
    #context { counter(page).display() }
  ]
}

// ── Header sub-components ─────────────────────────────────────────────────────

/// Show a GitHub project link aligned right.
#let github-link(github-path) = {
  set box(height: 11pt)
  align(right + horizon)[
    #fa-icon("github", fill: color-darkgray) #h(2pt)
    #link("https://github.com/" + github-path, github-path)
  ]
}

#let secondary-right-header(body) = {
  set text(size: 8pt, weight: "medium")
  body
}

#let tertiary-right-header(body) = {
  set text(weight: "light", size: 9pt)
  body
}

/// Two-column justified header (primary left, secondary right).
#let justified-header(primary, secondary) = {
  set block(above: 0.7em, below: 0.7em)
  pad[
    #__justify_align[
      == #primary
    ][
      #secondary-right-header[#secondary]
    ]
  ]
}

/// Smaller two-column justified header for role/date sub-lines.
#let secondary-justified-header(primary, secondary) = {
  __justify_align[
    === #primary
  ][
    #tertiary-right-header[#secondary]
  ]
}

// ── Resume template ───────────────────────────────────────────────────────────

/// Resume template. Sets page layout, heading styles, and renders the header
/// (name, positions, address, contact icons).
#let resume(
  author: (:),
  profile-picture: image,
  contact-items-separator: h(10pt),
  contact-items-inset: (left: 4pt),
  date: datetime.today().display("[month repr:long] [day], [year]"),
  accent-color: default-accent-color,
  sub-accent-color: default-sub-accent-color,
  colored-headers: true,
  show-footer: false,
  language: "en",
  font: ("Helvetica Neue", "Helvetica"),
  header-font: "Gill Sans",
  paper-size: "a4",
  use-smallcaps: true,
  show-address-icon: false,
  description: none,
  keywords: (),
  body,
) = {
  if type(accent-color) == str { accent-color = rgb(accent-color) }

  let desc = if description == none {
    "Résumé " + author.firstname + " " + author.lastname
  } else {
    description
  }

  show: body => context {
    set document(
      author: author.firstname + " " + author.lastname,
      title: "Résumé",
      description: desc,
      keywords: keywords,
    )
    body
  }

  // ── Page & base text ───────────────────────────────────────────────────────
  set text(font: font, lang: language, size: 8pt, fill: color-darkgray, fallback: true)

  set page(
    paper: paper-size,
    margin: (
      left: 8.5mm,
      right: 8.5mm,
      top: 7mm,
      bottom: if show-footer { 12mm } else { 8mm },
    ),
    footer: if show-footer [
      #__resume_footer(author, language, date, use-smallcaps: use-smallcaps)
    ] else [],
    footer-descent: 35%,
  )

  set par(spacing: 0.75em, justify: true)
  set list(marker: text(fill: accent-color, stroke: 0.5pt + accent-color, size: 1.3em, sym.circle.stroked))
  set heading(numbering: none, outlined: false)

  // ── Heading styles ─────────────────────────────────────────────────────────
  show heading.where(level: 1): it => block(above: 1.2em, sticky: true)[
    #set text(size: 12pt, weight: "bold")
    #set align(left)
    #let color = if colored-headers { accent-color } else { color-darkgray }
    #text(color)[#it.body]
    #box(width: 1fr, line(length: 100%, stroke: (
      paint: color,
      thickness: 1.55pt,
      cap: "round",
      dash: (array: (0pt, 3pt), phase: 0pt),
    )))
  ]

  show heading.where(level: 2): it => {
    set text(color-darkgray, size: 9pt, style: "normal", weight: "bold")
    it.body
  }

  show heading.where(level: 3): it => {
    set text(size: 10pt, weight: "regular")
    __apply_smallcaps(it.body, use-smallcaps)
  }

  // ── Header blocks ──────────────────────────────────────────────────────────
  if profile-picture != none {
    grid(
      columns: (100% - 4cm, 4cm),
      rows: 100pt,
      gutter: 10pt,
      centered-author-header(
        author,
        accent-color:            accent-color,
        sub-accent-color:        sub-accent-color,
        header-font:             header-font,
        language:                language,
        contact-items-separator: contact-items-separator,
        contact-items-inset:     contact-items-inset,
        show-address-icon:       show-address-icon,
        use-smallcaps:           use-smallcaps,
      ),
      align(left + horizon)[
        #block(clip: true, stroke: 0pt, radius: 2cm, width: 4cm, height: 4cm, profile-picture)
      ],
    )
  } else {
    centered-author-header(
      author,
      accent-color:            accent-color,
      sub-accent-color:        sub-accent-color,
      header-font:             header-font,
      language:                language,
      contact-items-separator: contact-items-separator,
      contact-items-inset:     contact-items-inset,
      show-address-icon:       show-address-icon,
      use-smallcaps:           use-smallcaps,
    )
  }

  body
}

// ── Resume components ─────────────────────────────────────────────────────────

/// Centered summary/profile block with a thin accent rule above it.
#let resume-summary(body) = {
  set text(size: 9.5pt, style: "normal", weight: "medium", fill: color-darknight)
  set par(justify: true)
  line(length: 100%, stroke: (paint: default-accent-color, thickness: 0.5pt))
  v(4pt)
  align(center)[#body]
}

/// Bullet-list body for a resume entry.
#let resume-item(body) = {
  set text(size: 8pt, style: "normal", weight: "light", fill: color-darknight)
  set block(above: 0.75em, below: 0.75em)
  set par(leading: 0.65em)
  block(above: 0.5em)[#body]
}

/// Inline project entry: bold title | description tag : body text.
#let resume-project(title: none, description: "", body) = {
  set par(leading: 0.65em, justify: true)
  block(above: 0.75em, below: 0.75em)[
    #text(size: 8pt, weight: "bold", fill: color-darkgray)[#title]#if description != "" [
      #text(size: 8pt, weight: "bold", fill: default-sub-accent-color)[ | #description]:]
    #text(size: 8pt, weight: "light", fill: color-darknight)[#body]
  ]
}

/// Justified entry header with optional inline-location/inline-title modes.
#let resume-entry(
  title: none,
  location: "",
  date: "",
  description: "",
  title-link: none,
  accent-color: default-accent-color,
  location-color: default-location-color,
  inline-location: false,
  inline-title: false,
) = {
  let title-content = if type(title-link) == str { link(title-link)[#title] } else { title }

  block(above: 1em, below: 0.65em, sticky: true)[
    #if inline-title {
      [#text(size: 8pt, weight: "bold", fill: color-darkgray)[#title-content]#if description != "" [
          #text(size: 8pt, fill: default-sub-accent-color)[ | #description]]]
    } else {
      pad[
        #if inline-location {
          let parts = ()
          if description != "" { parts.push(description) }
          if location != "" { parts.push(location) }
          let loc-text = parts.join(", ")
          let right-content = if date != "" and loc-text != "" {
            [#text(size: 9pt, fill: accent-color)[#loc-text]#text(size: 9pt, fill: default-sub-accent-color)[ | #date]]
          } else if date != "" {
            text(size: 9pt, fill: default-sub-accent-color)[#date]
          } else {
            text(size: 9pt, fill: accent-color)[#loc-text]
          }
          justified-header(upper(title-content), right-content)
        } else {
          justified-header(title-content, location)
          if description != "" or date != "" [
            #secondary-justified-header(description, date)
          ]
        }
      ]
    }
  ]
}

/// Show cumulative GPA.
#let resume-gpa(numerator, denominator) = {
  set text(size: 12pt, style: "italic", weight: "light")
  text[Cumulative GPA: #box[#strong[#numerator] / #denominator]]
}

/// Justified header for a certification and its date.
#let resume-certification(certification, date) = {
  justified-header(certification, date)
}

/// Bold category label for a skill row.
#let resume-skill-category(category) = {
  text(size: 8pt, style: "normal", weight: "black", hyphenate: false)[#category]
}

/// Light comma-joined list of skill values.
#let resume-skill-values(values) = {
  set text(size: 8pt, style: "normal", weight: "light")
  values.join(", ")
}

/// Single skill row: category (3fr) | values (8fr).
#let resume-skill-item(category, items) = {
  set block(below: 0.65em)
  set pad(top: 2pt)
  pad[
    #grid(
      columns: (3fr, 8fr),
      gutter: 10pt,
      align: left + top,
      resume-skill-category(category),
      resume-skill-values(items),
    )
  ]
}

/// Auto-sized two-column grid of skill categories and values.
#let resume-skill-grid(categories-with-values: (:)) = {
  set block(below: 1.25em)
  set pad(top: 2pt)
  pad[
    #grid(
      columns: (auto, auto),
      gutter: 10pt,
      align: left + top,
      ..categories-with-values
        .pairs()
        .map(((key, value)) => (resume-skill-category(key), resume-skill-values(value)))
        .flatten()
    )
  ]
}
