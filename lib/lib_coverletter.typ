#import "lib_common.typ": *

// Shared paragraph defaults for the cover letter body and helper functions.
#let default-par = (spacing: 0.75em, justify: true)

// ── Internal footer ───────────────────────────────────────────────────────────

#let __coverletter_footer(author, language, date, use-smallcaps: true) = {
  set text(fill: gray, size: 8pt)
  __justify_align_3[
    #__apply_smallcaps(date, use-smallcaps)
  ][
    #__apply_smallcaps(
      {
        let name = __format_author_name(author, language)
        name + " · Cover Letter"
      },
      use-smallcaps,
    )
  ][
    #context { counter(page).display() }
  ]
}

// ── Signature & closing defaults ──────────────────────────────────────────────

/// Default "Sincerely, [signature] Name" block.
#let default-signature(author, alignment, padding) = {
  align(alignment, pad(..padding)[
    #text(weight: "light")[Sincerely,] \
    #if ("signature" in author) { author.signature } \
    #text(weight: "bold")[#author.firstname #author.lastname]
  ])
}

/// Default "Attached: Curriculum Vitae" footer line.
#let default-closing() = {
  align(bottom)[
    #text(weight: "light", style: "italic")[Attached: Curriculum Vitae]
  ]
}

// ── Cover letter template ─────────────────────────────────────────────────────

/// Full-page cover letter layout with a right-aligned header (photo left,
/// name/contacts right), body text area, signature, and optional footer.
///
/// Note: if you want to reuse the resume header style (centered name, etc.)
/// on your cover letter, use the `resume()` template from lib_resume.typ
/// directly — that is the approach used in coverletter.typ in this project.
#let coverletter(
  author: (:),
  profile-picture: image,
  contact-items-separator: box(width: 6pt, align(center, sym.bar.v)),
  contact-items-inset: (:),
  heading-padding: (above: 2em, below: 1em),
  signature-padding: (top: 1em),
  signature-alignment: left,
  par-spacing: 1.5em,
  date: datetime.today().display("[month repr:long] [day], [year]"),
  accent-color: default-accent-color,
  language: "en",
  font: ("Helvetica Neue", "Helvetica"),
  header-font: "Gill Sans",
  show-footer: false,
  signature: none,
  closing: none,
  paper-size: "a4",
  use-smallcaps: true,
  show-address-icon: false,
  description: none,
  keywords: (),
  body,
) = {
  if type(accent-color) == str { accent-color = rgb(accent-color) }

  if signature == none {
    signature = default-signature(author, signature-alignment, signature-padding)
  }
  if closing == none {
    closing = default-closing()
  }

  let desc = if description == none {
    "Cover Letter " + author.firstname + " " + author.lastname
  } else {
    description
  }

  show: body => context {
    set document(
      author: author.firstname + " " + author.lastname,
      title: "Cover Letter",
      description: desc,
      keywords: keywords,
    )
    body
  }

  // ── Page & base text ───────────────────────────────────────────────────────
  set text(font: font, lang: language, size: 11pt, fill: color-darkgray, fallback: true)

  set page(
    paper: paper-size,
    margin: (
      left: 7mm,
      right: 7mm,
      top: 7mm,
      bottom: if show-footer { 12mm } else { 8mm },
    ),
    footer: if show-footer [
      #__coverletter_footer(author, language, date, use-smallcaps: use-smallcaps)
    ] else [],
    footer-descent: 35%,
  )

  set par(..default-par)
  set heading(numbering: none, outlined: false)

  show heading: it => block(..heading-padding)[
    #set text(size: 16pt, weight: "regular")
    #align(left)[
      #text[#strong[#text(accent-color)[#it.body]]]
      #box(width: 1fr, line(length: 100%))
    ]
  ]

  // ── Header blocks (photo left, info right) ─────────────────────────────────
  let name = {
    align(right)[
      #pad(bottom: 5pt)[
        #block[
          #set text(accent-color, size: 20pt, style: "normal", weight: "regular", font: header-font)
          #if language == "zh" or language == "ja" [
            #upper(author.lastname)#upper(author.firstname)
          ] else [
            #upper(author.firstname) #upper(author.lastname)
          ]
        ]
      ]
    ]
  }

  let positions = {
    set text(default-sub-accent-color, size: 12pt, weight: "regular")
    align(right)[
      #__apply_smallcaps(
        author.positions.join(text[#"  "#sym.dot.c#"  "]),
        use-smallcaps,
      )
    ]
  }

  let address = {
    set text(size: 9pt, weight: "bold", fill: color-gray)
    align(right)[
      #if ("address" in author) [
        #if show-address-icon [
          #__contact_item(
            (icon: address-icon, text: text(author.address)),
            inset: contact-items-inset,
          )
        ] else [
          #text(author.address)
        ]
      ]
    ]
  }

  let contacts = {
    set text(size: 8pt, weight: "light", style: "normal")
    let items = __format_contact_items(author)
    align(right, items.join(contact-items-separator))
  }

  grid(
    columns: (1fr, 2fr),
    rows: 100pt,
    align(left + horizon)[
      #block(clip: true, stroke: 0pt, radius: 2cm, width: 4cm, height: 4cm, profile-picture)
    ],
    [#name #positions #address #contacts],
  )

  {
    set par(spacing: par-spacing)
    set text(weight: "light")
    body
  }
  signature
  closing
}

// ── Cover letter content helpers ──────────────────────────────────────────────

/// Hiring entity block: company target (bold, left) with date (right),
/// then name/address in gray below.
#let hiring-entity-info(
  entity-info: (:),
  date: datetime.today().display("[month repr:long] [day], [year]"),
  use-smallcaps: true,
) = {
  set par(leading: 1em, ..default-par)
  pad(top: 1.5em, bottom: 1.5em)[
    #__justify_align[
      #text(weight: "bold", size: 12pt)[#entity-info.target]
    ][
      #text(weight: "light", style: "italic", size: 9pt)[#date]
    ]
    #pad(top: 0.65em, bottom: 0.65em)[
      #text(weight: "regular", fill: color-gray, size: 9pt)[
        #__apply_smallcaps(entity-info.name, use-smallcaps) \
        #entity-info.street-address \
        #entity-info.city \
      ]
    ]
  ]
}

/// Underlined "Job Application for [position]" heading with salutation below.
#let letter-heading(
  job-position: "",
  addressee: "",
  dear: "",
  padding: (top: 1em, bottom: 1em),
) = {
  set par(..default-par)
  underline(evade: false, stroke: 0.5pt, offset: 0.3em)[
    #text(weight: "bold", size: 12pt)[Job Application for #job-position]
  ]
  pad(..padding)[
    #text(weight: "light", fill: color-gray)[
      #if dear == "" [Dear] else [#dear]
      #addressee,
    ]
  ]
}
