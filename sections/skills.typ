#import "../lib/lib_resume.typ": *

= SKILLS

#context {
  let label-w = calc.max(
    ..("Languages", "Frameworks", "Tools", "Libraries", "Cloud", "Libraries")
      .map(l => measure(text(size: 8pt, weight: "bold")[#l:]).width)
  )

  let row(name, items, hide-label: false) = {
    set par(hanging-indent: label-w + 5pt)
    let label-color = if hide-label { white } else { black }
    [#box(width: label-w)[#text(size: 8pt, weight: "bold", fill: label-color)[#name:]]#h(5pt)#text(size: 8pt, weight: "light")[#items.join(", ")]]
  }

  block(below: 0.75em)[
    #pad(top: 2pt)[
      #grid(
        columns: (1fr, 1fr),
        column-gutter: 3pt,
        align: top,
        stack(dir: ttb, spacing: 0.65em,
          row("Languages", ("Python", "R", "Julia", "Rust", "MATLAB", "SQL")),
          row("Tools", ("GIT", "dbt", "Docker", "JupyterLab", "Pluto", "AirFlow", "MLFlow", "Streamlit")),
          row("Cloud", ("AWS", "Azure", "DataBricks", "GCP", "Snowflake")),
        ),
        stack(dir: ttb, spacing: 0.65em,
          row("Frameworks", ("TensorFlow", "PyTorch", "JAX", "LangChain", "DsPy")),
          row("Libraries", ("Numpy", "Pandas", "Polars", "PySpark", "PyCuda", "statsmodels", )),
          row("Libraries", ("Scikit-learn", "Nixtla", "Prophet", "PyMC3", "DoWhy"), hide-label: true)
        ),
      )
    ]
  ]
}


// 