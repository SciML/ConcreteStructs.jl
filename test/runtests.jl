using Pkg

const GROUP = get(ENV, "GROUP", "All")

if GROUP == "All" || GROUP == "Core"
    include("core.jl")
end

if GROUP == "All" || GROUP == "QA"
    # The QA group carries its own dependencies (Aqua, JET) in test/qa/Project.toml.
    Pkg.activate(joinpath(@__DIR__, "qa"))
    Pkg.develop(PackageSpec(path = joinpath(@__DIR__, "..")))
    Pkg.instantiate()
    include(joinpath(@__DIR__, "qa", "qa.jl"))
end
