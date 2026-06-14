using Pkg
using SafeTestsets

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

@safetestset "Invalid usage error path" begin
    using ConcreteStructs
    using Test
    # `@concrete` applied to something that is neither a struct definition nor a
    # macrocall wrapping one reaches `_find_struct_def`'s fallthrough, which must
    # raise a clear `ErrorException` (previously a `nerror` typo made this throw
    # an `UndefVarError` instead).
    @test_throws "Invalid usage of @concrete." @macroexpand(@concrete x = 1)
end
