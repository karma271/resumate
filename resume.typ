#import "lib/lib_resume.typ": *

// ── Debug grid: flip to true to overlay an alignment grid ──────────────
#let show-debug-grid = false

#show: body => {
  set page(background: if show-debug-grid {
    rect(
      width: 100%,
      height: 100%,
      stroke: none,
      fill: tiling(size: (5mm, 5mm))[
        #place(line(start: (0pt, 0pt), end: (5mm, 0pt), stroke: 0.3pt + rgb("#aaccff80")))
        #place(line(start: (0pt, 0pt), end: (0pt, 5mm), stroke: 0.3pt + rgb("#aaccff80")))
      ],
    )
  } else { none })
  body
}

#show: resume.with(
  author: (
      firstname: "Prasoon",
      lastname: "Karmacharya",
      email: "pk425@cornell.edu",
      phone: "(+1) 607-319-1661",
      github: "karma271",
      linkedin: "karmacharya",
      positions: (
        "Data Scientist",
      )
  ),
  profile-picture: none,
  date: datetime.today().display(),
  paper-size: "us-letter"
)

#include "sections/summary.typ"
#include "sections/skills.typ"
#include "sections/experience.typ"
#include "sections/projects.typ"
#block(above: 1.5em)[
  #grid(
    columns: (1fr, 1fr),
    column-gutter: 15pt,
    include "sections/education.typ",
    include "sections/notable_accomplishments.typ",
  )
]
