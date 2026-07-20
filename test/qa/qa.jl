using ConcreteStructs
using JET
using SciMLTesting
using Test

run_qa(ConcreteStructs; explicit_imports = true, api_docs_kwargs = (; rendered = true))
