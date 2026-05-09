#import "lib/lib_coverletter.typ": *

// ── Author ──────────────────────────────────────────────────────────────────
#let cl-author = (
  firstname:  "Prasoon",
  lastname:   "Karmacharya",
  email:      "pk425@cornell.edu",
  phone:      "(+1) 607-319-1661",
  github:     "karma271",
  linkedin:   "karmacharya",
  positions:  ("Data Scientist",),
)

// ── Cover letter variables ──────────────────────────────────────────────────
#let cl-company    = "MOONSHOT PROJECT"
#let cl-job-title  = "Principal Data Scientist"
#let cl-job-id     = "XYZ"
#let cl-salutation = "Dear Hiring Manager,"

// ── Page & base text ────────────────────────────────────────────────────────
#set text(font: ("Helvetica Neue", "Helvetica"), size: 9pt, fill: color-darkgray, fallback: true)
#set page(paper: "us-letter", margin: (left: 8.5mm, right: 8.5mm, top: 7mm, bottom: 8mm))
#set par(spacing: 1.25em, justify: false, leading: 0.8em)

// ── Header (same as resume) ─────────────────────────────────────────────────
#centered-author-header(cl-author, show-separator: true)

// ── Letter content ──────────────────────────────────────────────────────────
#pad(x: 6mm)[

  #v(1.5em)
  #set text(size: 9pt)
  #text(weight: "bold", fill: default-accent-color)[#cl-company]

  #v(0.5em)
  Re: #text(weight: "bold")[#cl-job-title]#if cl-job-id != "" [ (ID: #cl-job-id)]

  #v(2em)
  #cl-salutation

  #set text(size: 10pt, fill: color-darknight, weight: "light")
  #set par(spacing: 1.25em, justify: false, leading: 0.8em)
  #v(1em)

  National Grid's transition toward a sustainable energy system introduces a unique technical challenge: reconciling shifting consumption patterns with fragmented multi-channel data. Successfully navigating this complexity requires a lead who prioritizes the ownership of large-scale, production-grade systems that translate behavioral signals into measurable operational efficiency. My record of deploying scalable high-impact machine learning systems at Nike and Babylon Health demonstrates my ability to lead technical strategy through precisely these types of high-stakes, undefined challenges.

  At Nike, I took end-to-end ownership of hierarchical demand forecasting models that improved accuracy by up to 20% across global geographies. I navigated the ambiguity of new product launches by implementing cold-start forecasting using similarity embeddings and stabilized early-season signals. Beyond the modeling, I operationalized the entire production lifecycle—including batch scoring, backtesting, and real-time monitoring—to accelerate the cycle from analysis to decision. To bridge the gap between technical output and business utility, I developed a "Forecasting Agent," an agentic tool that empowered non-technical stakeholders to conduct sophisticated simulations independently, ensuring sustained adoption across Finance and Supply Chain departments.

  My experience at Babylon Health further proves my capacity to architect systems that solve interdisciplinary bottlenecks. I designed service demand models and applied constraint programming to optimize scheduling, which reduced patient wait times by 30% while increasing system utilization to 85%. This required a high degree of collaboration, discipline and the ability to build scalable ML workflows from the ground up in a volatile environment. I do not just deliver insights; I build the infrastructure—including graph-based segmentation and RAG-based signal extraction—that allows those insights to scale.

  I am prepared to apply this experience in system ownership and technical leadership to National Grid's Customer Performance Lab. By unifying cross-channel datasets and architecting robust predictive pipelines, I will ensure your data strategy directly minimizes service friction and supports the broader mission of reducing energy delivery costs. I look forward to discussing how my background in optimizing complex, constrained systems can contribute to your upcoming customer-facing initiatives.

  #v(3em)
  Sincerely,

  #text(weight: "bold")[Prasoon Karmacharya]
]
