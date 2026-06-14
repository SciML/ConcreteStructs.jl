using SafeTestsets

@safetestset "Code quality (Aqua.jl)" begin
    using ConcreteStructs
    using Aqua
    Aqua.test_all(ConcreteStructs)
end

@safetestset "Code linting (JET.jl)" begin
    using ConcreteStructs
    using JET
    JET.test_package(ConcreteStructs; target_defined_modules = true)
end
