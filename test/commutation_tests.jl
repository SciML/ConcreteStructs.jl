using ConcreteStructs
using Test

# this has been working for a while already
Base.@kwdef @concrete struct Foo2{T <: Real}
    x::T = 1.0
    y = true
    z = 42
end

foo = Foo2()
@test typeof(foo) === Foo2{Float64, Bool, Int64}

# this is new
@concrete Base.@kwdef struct Foo3{T <: Real}
    x::T = 1.0
    y = true
    z = 42
end

foo = Foo3()
@test typeof(foo) === Foo3{Float64, Bool, Int64}

foo = Foo3(z = [1, 2, 3])
@test typeof(foo) === Foo3{Float64, Bool, Vector{Int64}}

# terse test case, unfortunately doesn't work the other way around. But also never did.
@concrete terse Base.@kwdef struct TerseKWDef
    a = 1.0
    b = true
end
terse_kw_def = TerseKWDef(b = false)
@test typeof(terse_kw_def) === TerseKWDef{Float64, Bool}
