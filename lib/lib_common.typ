#import "@preview/fontawesome:0.6.0": *

// ── Colors ────────────────────────────────────────────────────────────────────
#let color-darknight        = rgb("#131A28")
#let color-darkgray         = rgb("#333333")
#let color-gray             = rgb("#5d5d5d")
#let default-accent-color     = rgb("#7789DA")
#let default-sub-accent-color = rgb("#71797E")
#let default-location-color   = rgb("#333333")

// ── Icons ─────────────────────────────────────────────────────────────────────
#let linkedin-icon       = box(fa-icon("linkedin",            fill: default-accent-color))
#let telegram-icon       = box(fa-icon("telegram",            fill: default-accent-color))
#let github-icon         = box(fa-icon("github",              fill: default-accent-color))
#let gitlab-icon         = box(fa-icon("gitlab",              fill: default-accent-color))
#let bitbucket-icon      = box(fa-icon("bitbucket",           fill: default-accent-color))
#let twitter-icon        = box(fa-icon("twitter",             fill: default-accent-color))
#let bluesky-icon        = box(fa-icon("bluesky",             fill: default-accent-color))
#let mastodon-icon       = box(fa-icon("mastodon",            fill: default-accent-color))
#let google-scholar-icon = box(fa-icon("google-scholar",      fill: default-accent-color))
#let orcid-icon          = box(fa-icon("orcid",               fill: default-accent-color))
#let phone-icon          = box(fa-icon("phone",               fill: default-accent-color))
#let email-icon          = box(fa-icon("envelope",            fill: default-accent-color))
#let birth-icon          = box(fa-icon("cake",                fill: default-accent-color))
#let homepage-icon       = box(fa-icon("home",                fill: default-accent-color))
#let website-icon        = box(fa-icon("globe",               fill: default-accent-color))
#let address-icon        = box(fa-icon("location-crosshairs", fill: default-accent-color))

// ── Layout utilities ──────────────────────────────────────────────────────────

#let __justify_align(left_body, right_body) = {
  block[
    #left_body
    #box(width: 1fr)[
      #align(right)[#right_body]
    ]
  ]
}

#let __justify_align_3(left_body, mid_body, right_body) = {
  block[
    #box(width: 1fr)[#align(left)[#left_body]]
    #box(width: 1fr)[#align(center)[#mid_body]]
    #box(width: 1fr)[#align(right)[#right_body]]
  ]
}

// ── Shared helpers ────────────────────────────────────────────────────────────

#let __format_author_name(author, language) = {
  if language == "zh" or language == "ja" {
    str(author.lastname) + str(author.firstname)
  } else {
    str(author.firstname) + " " + str(author.lastname)
  }
}

#let __apply_smallcaps(content, use-smallcaps) = {
  if use-smallcaps { smallcaps(content) } else { content }
}

// Single contact item — icon + linked or plain text.
#let __contact_item(item, link-prefix: "", inset: (:)) = {
  box[
    #set align(bottom)
    #if ("icon" in item) [#item.icon]
    #box(inset: inset)[
      #if ("link" in item) {
        link(link-prefix + item.link)[#item.text]
      } else {
        item.text
      }
    ]
  ]
}

// Build the ordered list of contact items from the author dictionary.
#let __format_contact_items(author, item-inset: (:)) = {
  let ci(item, link-prefix: "") = {
    __contact_item(item, link-prefix: link-prefix, inset: item-inset)
  }

  let items = ()

  if "birth" in author {
    items.push(ci((text: author.birth, icon: birth-icon)))
  }
  if "phone" in author {
    items.push(ci((text: author.phone, icon: phone-icon, link: author.phone), link-prefix: "tel:"))
  }
  if "email" in author {
    items.push(ci((text: author.email, icon: email-icon, link: author.email), link-prefix: "mailto:"))
  }
  if "homepage" in author {
    items.push(ci((text: author.homepage, icon: homepage-icon, link: author.homepage)))
  }
  if "github" in author {
    items.push(ci((text: author.github, icon: github-icon, link: author.github), link-prefix: "https://github.com/"))
  }
  if "gitlab" in author {
    items.push(ci((text: author.gitlab, icon: gitlab-icon, link: author.gitlab), link-prefix: "https://gitlab.com/"))
  }
  if "bitbucket" in author {
    items.push(ci((text: author.bitbucket, icon: bitbucket-icon, link: author.bitbucket), link-prefix: "https://bitbucket.org/"))
  }
  if "linkedin" in author {
    items.push(ci(
      (text: "in/" + author.linkedin, icon: linkedin-icon, link: author.linkedin),
      link-prefix: "https://www.linkedin.com/in/",
    ))
  }
  if "twitter" in author {
    items.push(ci((text: "@" + author.twitter, icon: twitter-icon, link: author.twitter), link-prefix: "https://twitter.com/"))
  }
  if "telegram" in author {
    items.push(ci((text: "@" + author.telegram, icon: telegram-icon, link: author.telegram), link-prefix: "https://t.me/"))
  }
  if "bluesky" in author {
    items.push(ci((text: "@" + author.bluesky, icon: bluesky-icon, link: author.bluesky), link-prefix: "https://bsky.app/profile/"))
  }
  if "mastodon" in author {
    items.push(ci(
      (text: "@" + author.mastodon, icon: mastodon-icon, link: author.mastodon),
      link-prefix: "https://mastodon.social/@",
    ))
  }
  if "scholar" in author {
    let fullname = str(author.firstname + " " + author.lastname)
    items.push(ci(
      (text: fullname, icon: google-scholar-icon, link: author.scholar),
      link-prefix: "https://scholar.google.com/citations?user=",
    ))
  }
  if "orcid" in author {
    items.push(ci((text: author.orcid, icon: orcid-icon, link: author.orcid), link-prefix: "https://orcid.org/"))
  }
  if "website" in author {
    items.push(ci((text: author.website, icon: website-icon, link: author.website)))
  }
  if "custom" in author and type(author.custom) == array {
    for item in author.custom {
      if "text" in item {
        items.push(ci(
          (
            text: item.text,
            icon: if ("icon" in item) { box(fa-icon(item.icon, fill: default-accent-color)) } else { none },
            link: if ("link" in item) { item.link } else { none },
          ),
          link-prefix: "",
        ))
      }
    }
  }

  items
}

// ── Shared centered header ────────────────────────────────────────────────────

/// Renders the centered name / positions / contacts header used by both the
/// resume and the cover letter.  Pass `show-separator: true` to append the
/// thin accent rule (used by the cover letter; the resume draws it separately
/// via resume-summary).
#let centered-author-header(
  author,
  accent-color:            default-accent-color,
  sub-accent-color:        default-sub-accent-color,
  header-font:             "Gill Sans",
  language:                "en",
  contact-items-separator: h(10pt),
  contact-items-inset:     (left: 4pt),
  show-address-icon:       false,
  use-smallcaps:           true,
  show-separator:          false,
) = {
  align(center)[
    #pad(bottom: 1pt)[
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

  {
    set text(sub-accent-color, size: 14pt, weight: "regular")
    align(center)[
      #upper(author.positions.join(text[#"  "#sym.dot.c#"  "]))
    ]
  }

  if "address" in author {
    set text(size: 9pt, weight: "regular")
    align(center)[
      #if show-address-icon [
        #__contact_item(
          (icon: address-icon, text: text(author.address)),
          inset: contact-items-inset,
        )
      ] else [
        #text(author.address)
      ]
    ]
  }

  {
    set box(height: 9pt)
    set text(size: 9pt, weight: "regular", style: "normal")
    let items = __format_contact_items(author, item-inset: contact-items-inset)
    align(center, items.join(contact-items-separator))
  }

  if show-separator {
    v(3pt)
    line(length: 100%, stroke: (paint: accent-color, thickness: 0.5pt))
  }
}
