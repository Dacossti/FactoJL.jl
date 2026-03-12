# FactoJL.jl

[![Build Status](https://github.com/Dacossti/FactoJL.jl/actions/workflows/CI.yml/badge.svg?branch=master)](https://github.com/Dacossti/FactoJL.jl/actions/workflows/CI.yml?query=branch%3Amaster)


**FactoJulia** is a Julia package for performing **Principal Component Analysis (PCA)** with visualization, inspired by FactoMineR in R. It provides clear outputs for eigenvalues, loadings, variable contributions, and automatically generates and saves PCA plots.

## Features

- Compute PCA on numeric datasets
- Center and scale variables
- Print PCA results like FactoMineR (coordinates, cos2, contributions)
- Generate high-quality plots:
  - Scree plot
  - Individuals factor map
  - Variables correlation circle
- Save plots automatically for future reference

---

## Installation

```julia
using Pkg
Pkg.add("https://github.com/Dacossti/FactoJL.jl.git")
```

Or, for development:

```julia
Pkg.clone("https://github.com/Dacossti/FactoJL.jl.git")
Pkg.activate("FactoJL.jl")
```

## Usage
```julia
using FactoJL
using CSV, DataFrames

# Load a dataset
df = CSV.read("PATH TO YOUR DATA.csv", DataFrame)

# Or if you wish to quickly check correct installation, uncomment the line below and remove the previous one 
# df = CSV.read("test/test_data.csv", DataFrame)     

# Perform PCA
result = PCA_(df; scale=true, ncp=5, graph=true)

# Access PCA outputs
scores = result.scores       # Principal component scores
loadings = result.loadings   # Loadings (eigenvectors)
eigvals = result.eigvals     # Eigenvalues
propvar = result.propvar     # Variance explained (%)
cumvar = result.cumvar       # Cumulative variance explained
```

## Output Example

- **Scree plot** – shows variance explained by each component
- **Individuals factor map** – visualizes samples in PCA space with 4 quadrants
- **Variables factor map** – correlation circle with variable arrows

All plots are automatically displayed and saved in the *src/test/plots* folder.


## Advanced Usage

You can control which components to display in factor maps:

```julia
plot_PCA_individuals(result.scores; pcs=(1,3))
plot_PCA_variables(result.loadings; pcs=(1,3), var_names=result.colnames)
```

## Repository structure

```
FactoJL.jl/
├─ src/
│  ├─ pca.jl           # Main PCA functions
│  ├─ FactoJL.jl    # Module entrypoint
│  └─ test/
│     └─ plots/        # Automatically saved plots
├─ test/               # Unit tests
├─ Project.toml
└─ README.md
```

## Citation / Acknowledgement

If you use FactoJL.jl in your work, please mention it in your publication, project, or report. A simple citation like the following is appreciated:

>  PCA analysis was performed using the [FactoJL.jl package](https://github.com/Dacossti/FactoJL.jl) by [Stave Icnel Dany OSIAS](https://github.com/Dacossti).
