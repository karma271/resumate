#import "../template_modern_cv/lib.typ": *

= EDUCATION

#let edu-entry(title, date, location, description: "") = {
  block(above: 0.5em, below: 0pt)[
    #block[
      #text(size: 8pt, weight: "bold", fill: color-darkgray)[#title]
      #box(width: 1fr)[
        #align(right)[
          #text(size: 8pt, fill: default-accent-color)[#date]#text(size: 8pt, fill: default-sub-accent-color)[ | #location]
        ]
      ]
    ]
    #if description != "" [
      #block(above: 0.1em)[#text(size: 8pt, weight: "light", fill: color-darknight)[#description]]
    ]
  ]
}

#edu-entry("Data Science Immersive Fellow", "2020", "Boston, MA")
#edu-entry("Cornell University", "2015", "Ithaca, NY", description: "Materials Science and Engineering, BSc.")
