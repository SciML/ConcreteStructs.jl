using SafeTestsets

@safetestset "Unit tests" begin
    include("unit_tests.jl")
end

@safetestset "End-to-end tests" begin
    include("end_to_end_tests.jl")
end

@safetestset "Issue #3" begin
    include("issue_3.jl")
end

@safetestset "Commutation with other Macros" begin
    include("commutation_tests.jl")
end
