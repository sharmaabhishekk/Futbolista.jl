<img src="logo/futbolista.png" alt="Futbolista Logo">

[![Build Status](https://travis-ci.com/sharmaabhishekk/Futbolista.jl.svg?branch=master)](https://travis-ci.com/sharmaabhishekk/Futbolista.jl)
[![Build Status](https://ci.appveyor.com/api/projects/status/github/sharmaabhishekk/Futbolista.jl?svg=true)](https://ci.appveyor.com/project/sharmaabhishekk/Futbolista-jl)
[![Coverage](https://codecov.io/gh/sharmaabhishekk/Futbolista.jl/branch/master/graph/badge.svg)](https://codecov.io/gh/sharmaabhishekk/Futbolista.jl)
[![Coverage](https://coveralls.io/repos/github/sharmaabhishekk/Futbolista.jl/badge.svg?branch=master)](https://coveralls.io/github/sharmaabhishekk/Futbolista.jl?branch=master)


# What is Futbolista.jl?

Futbolista.jl is a package to make some common football analytics tasks easier to do in Julia. You can load [Statsbomb's public dataset](https://github.com/statsbomb/open-data) using it, as well as make some basic plots with it - pitches, and [passmaps](https://sharmaabhishekk.github.io/projects/passmap). 

## Getting Started

### Installation

```julia
using Pkg
Pkg.add("Futbolista")
```
### Using Futbolista

Please check out the `examples` directory to know more about the functions available. 

## How to Contribute

Some of the things to be added to the package are:

* Dataloaders for other free public sources (Wyscout, Metrica, fbref)
* Support more pitch types 
* More typical plots

If you can help with any of them, please don't hesitate to fork, and PR! A great guide to contributing to Julia packages is [here](https://www.youtube.com/watch?v=QVmU29rCjaA&t=1796s). 

-------------------
