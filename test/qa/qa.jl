using ConcreteStructs
using JET
using SciMLTesting
using Test

run_qa(
    ConcreteStructs;
    jet_kwargs = (; target_modules = (ConcreteStructs,)),
    explicit_imports = true,
)
