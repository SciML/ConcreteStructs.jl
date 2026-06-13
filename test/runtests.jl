using SciMLTesting
using ConcreteStructs
using Test

run_tests(;
    core = joinpath(@__DIR__, "core.jl"),
    qa = (;
        body = joinpath(@__DIR__, "qa", "qa.jl"),
        env = joinpath(@__DIR__, "qa"),
    ),
)

@testset "Invalid usage error path" begin
    # `@concrete` applied to something that is neither a struct definition nor a
    # macrocall wrapping one reaches `_find_struct_def`'s fallthrough, which must
    # raise a clear `ErrorException` (previously a `nerror` typo made this throw
    # an `UndefVarError` instead).
    @test_throws "Invalid usage of @concrete." @macroexpand(@concrete x = 1)
end
