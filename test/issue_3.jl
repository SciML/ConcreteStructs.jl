using ConcreteStructs
using LinearAlgebra: Adjoint
using Test

@concrete struct Foo{T <: Real}
    x::T
    y <: Real
    z <: AbstractMatrix{T}
end

foo = Foo(1, 1.0, [1, 2]')

@test typeof(foo) === Foo{Int, Float64, Adjoint{Int, Vector{Int}}}
