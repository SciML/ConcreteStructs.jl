using SciMLTesting: run_qa
using ConcreteStructs
using Aqua
using JET
using Test

run_qa(
    ConcreteStructs;
    Aqua = Aqua,
    JET = JET,
    jet = true,
    jet_kwargs = (; target_defined_modules = true),
)
