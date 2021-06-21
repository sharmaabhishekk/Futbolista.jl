<img src="logo/futbolista.png" alt="Futbolista Logo">

[![Build Status](https://ci.appveyor.com/api/projects/status/github/sharmaabhishekk/Futbolista.jl?svg=true)](https://ci.appveyor.com/project/sharmaabhishekk/Futbolista-jl)
[![Coverage](https://codecov.io/gh/sharmaabhishekk/Futbolista.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/sharmaabhishekk/Futbolista.jl)

# What is Futbolista.jl?

**Futbolista.jl is a package to make some common football analytics tasks easier to do in Julia.** You can
* load [Statsbomb's public dataset](https://github.com/statsbomb/open-data)
* plot pitches
* plot [passmaps](https://sharmaabhishekk.github.io/projects/passmap). 

## Getting Started

### Installation

```julia
using Pkg
Pkg.add("Futbolista")
```
### Using Futbolista

Please check out the pluto notebooks in the `examples` directory to know more about the functions available. 

## How to Contribute

Some of the things to be added to the package are:

* Dataloaders for other free public sources (Wyscout, Metrica, Fbref)
* Support more pitch types (Opta, Wyscout, Metrica, Tracab)
* More typical plots (pass sonars, pizza plots)

If you want to help with any of them, please don't hesitate to fork, and PR! A great guide to contributing to Julia packages is [here](https://www.youtube.com/watch?v=QVmU29rCjaA&t=1796s). 

-------------------
