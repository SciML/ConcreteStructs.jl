using Documenter
using Documenter.Remotes: GitHub
using ConcreteStructs

DocMeta.setdocmeta!(ConcreteStructs, :DocTestSetup, :(using ConcreteStructs); recursive = true)

makedocs(
    modules = [ConcreteStructs],
    sitename = "ConcreteStructs.jl",
    pages = [
        "Home" => "index.md",
        "Walkthrough" => "walkthrough.md",
        "API" => "api.md",
    ],
    format = Documenter.HTML(
        canonical = "https://jonniedie.github.io/ConcreteStructs.jl/stable",
        prettyurls = get(ENV, "CI", nothing) == "true",
    ),
    repo = GitHub("jonniedie/ConcreteStructs.jl"),
    authors = "Jonnie Diegelman",
    warnonly = [:missing_docs],
)

# Documenter can also automatically deploy documentation to gh-pages.
# See "Hosting Documentation" and deploydocs() in the Documenter manual
# for more information.
deploydocs(
    repo = "github.com/jonniedie/ConcreteStructs.jl.git"
)
