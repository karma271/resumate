#import "../lib/lib_resume.typ": *

= SKILLS

#let cat(name) = text(size: 8pt)[*#name:*]
#let vals(items) = text(size: 8pt, weight: "light")[#items.join(", ")]

#block(below: 0.75em)[#grid(
  columns: (1fr, 1fr),
  column-gutter: 16pt,
  pad(top: 2pt,
    grid(
      columns: (auto, 1fr),
      column-gutter: 5pt,
      row-gutter: 0.65em,
      align: left + top,
      cat("Languages"),
      vals(("Python", "R", "Julia", "Rust", "MATLAB", "SQL")),
      cat("Tools"),
      vals(("GIT", "dbt", "Docker", "JupyterLab", "Pluto", "AirFlow", "MLFlow", "Streamlit")),
      cat("Cloud"),
      vals(("AWS", "Azure", "DataBricks", "GCP", "Snowflake")),
    )
  ),
  pad(top: 2pt,
    grid(
      columns: (auto, 1fr),
      column-gutter: 5pt,
      row-gutter: 0.65em,
      align: left + top,
      cat("Frameworks"),
      vals(("TensorFlow", "PyTorch", "JAX", "LangChain", "DsPy")),
      cat("Libraries"),
      vals(("Numpy", "Pandas", "Polars", "PySpark", "PyCuda", "statsmodels", "Scikit-learn", "Nixtla", "Prophet", "PyMC3", "DoWhy")),
    )
  ),
)]
