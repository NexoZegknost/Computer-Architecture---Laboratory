# Computer Architecture Laboratory (CO2008)

[![CI](https://github.com/NexoZegknost/Computer-Architecture---Laboratory/actions/workflows/ci.yml/badge.svg)](https://github.com/NexoZegknost/Computer-Architecture---Laboratory/actions/workflows/ci.yml)

Laboratory work for the **Computer Architecture** course at Ho Chi Minh City University of Technology (HCMUT), VNU-HCM.
Each lab consists of **MIPS assembly** programs (run on the MARS simulator) and a **LaTeX report**.

## Labs

| Lab | Topic | Report |
|-----|-------|--------|
| [Lab 1](Lab%201) | Arithmetic instructions | [Release `lab-1`](../../releases/tag/lab-1) |
| [Lab 2](Lab%202) | – | – |
| [Lab 3](Lab%203) | – | – |
| [Lab 4](Lab%204) | – | – |

## Repository structure

```
.
├── Template/              # Clean skeleton for a new lab
├── Lab N/
│   ├── Lab_N.pdf          # Assignment
│   ├── Implementation/    # ExerciseK.asm
│   └── Report/            # LaTeX report
│       ├── main.tex
│       ├── config/        # info.tex, packages.tex, style.tex, ...
│       ├── sections/      # titlepage, introduction, exercises/, conclusion
│       └── images/        # logo, result screenshots exK.png
├── Manual/                # MIPS and MARS reference documents
├── tools/                 # MARS (.jar) used by CI
└── .github/               # CI/Release workflows, issue template
```

The report includes the source code directly from `../Implementation`, so each exercise has a single copy of its code.

## Building a report

- Requirements: TeX Live or MiKTeX, compiled with **XeLaTeX** (Vietnamese support).
- VS Code + LaTeX Workshop: open `Lab N/Report/main.tex` and build; the output goes to `Report/build/`.
- Command line:

  ```bash
  cd "Lab 1/Report"
  latexmk -xelatex -outdir=build main.tex
  ```

## Running the MIPS programs

Open a `.asm` file in MARS (`tools/Mars45.jar`, requires Java), then **Assemble** and **Run**.
To check the syntax from the command line:

```bash
java -jar tools/Mars45.jar nc a "Lab 1/Implementation/Exercise1.asm"
```

## Creating a new lab

1. Copy `Template` to `Lab N` and put the assignment in `Lab N/Lab_N.pdf`.
2. Edit `Report/config/info.tex` (`\LabNumber`, `\LabTitle`, `\ReportDate`).
3. For each additional exercise, duplicate `Implementation/Exercise1.asm` and
   `Report/sections/exercises/ex1.tex`, then add an `\input` line to `Report/sections/exercises.tex`.
4. Open an issue from the **Lab** template to track progress.

## Automation (GitHub Actions)

| Workflow | Trigger | What it does |
|----------|---------|--------------|
| **CI** | Every push to `main` | Assembles every `.asm` file with MARS and builds every report; PDFs are available under *Artifacts* |
| **Release** | Publishing a release tagged `lab-N` | Attaches `Lab-N-Report.pdf` and `Lab-N-Implementation.zip` to the release |
