using ConcreteStructs
using Aqua
using JET
using Test

@testset "Code quality (Aqua.jl)" begin
    Aqua.test_all(ConcreteStructs)
end

@testset "Code linting (JET.jl)" begin
    JET.test_package(ConcreteStructs; target_defined_modules = true)
end
