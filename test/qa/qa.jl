using ConcreteStructs
using Aqua
using JET
using ExplicitImports
using SciMLTesting
using Test

run_qa(
    ConcreteStructs;
    Aqua = Aqua,
    JET = JET,
    jet = true,
    jet_kwargs = (; target_modules = (ConcreteStructs,)),
    ExplicitImports = ExplicitImports,
    explicit_imports = true,
)
