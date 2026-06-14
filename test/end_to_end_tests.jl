using ConcreteStructs
using LinearAlgebra: Adjoint
using Suppressor
using Test

# Test setup
@concrete struct Plain end
plain = Plain()

@concrete terse struct PlainTerse end
plain_terse = PlainTerse()

"test"
@concrete struct PlainDoc end
plain_doc = PlainDoc()

"test"
@concrete terse struct PlainTerseDoc end
plain_terse_doc = PlainTerseDoc()

@concrete struct Args
    a
    b
end
args = Args(1 + im, "hi")

@concrete terse struct ArgsTerse <: Number
    a
    b
end
args_terse = ArgsTerse(1 + im, "hi")

@concrete mutable struct SubtypedMutable <: Number
    a
    b
end
subtyped_mutable = SubtypedMutable(3.0, 4.0f0)

@concrete struct Partial{A}
    # Hey there, I'm a comment
    a::A

    "And I'm a docsctring"
    b
end
partial = Partial(:yo, 1 // 2)

@concrete mutable struct ConstructorMutable{iip, C}
    a
    b
    c::C
end
ConstructorMutable(a, b, c) = ConstructorMutable{true}(a, b, eltype(a)(c))
constructor_mutable = ConstructorMutable([1.0 + im, 2], 'r', 1.5)
constructor_mutable.b = 'h'

@concrete terse struct TerseSameType{A}
    a::A
    b::A
end
function TerseSameType(a::A, b::B) where {A, B}
    T = promote_type(A, B)
    return TerseSameType{T}(T(a), T(b))
end
terse_same_type = TerseSameType(1 + im, 5.0f0)

@concrete terse struct FullyParameterized{B}
    a::Symbol
    b::B
end
fully_parameterized = FullyParameterized(:sine, sin)

@concrete mutable struct ParameterizedSubtyped{T, N, B <: AbstractArray{T, N}} <: AbstractArray{T, N}
    a
    b::B
    c::T
end
parameterized_subtyped = ParameterizedSubtyped(:🏦, [1, 2, 3], 4)
Base.size(x::ParameterizedSubtyped) = size(x.b)
Base.getindex(x::ParameterizedSubtyped, i...) = x.b[i...]

@concrete terse struct HangingTypeParam{iip}
    a
    b
end
hanging_type_param = HangingTypeParam{true}(1, 2.0)

@concrete terse struct HangingTypeParam2{iip, B}
    a
    b::B
end
hanging_type_param2 = HangingTypeParam2{true}(1, 2.0)


Base.@kwdef @concrete struct KWDef
    a = "ayyy"
    b::Float64 = 4.0
    c <: Real = 3
    d
    e::Float64
    f <: Real
end
kwdef = KWDef(d = "hi", e = 2.0, f = 1 // 2)


# Run tests
@test_throws ErrorException args.a = 2 + im
@test_throws MethodError subtyped_mutable.a = "hi"

@test typeof(partial) |> isconcretetype
@test typeof(terse_same_type.a) === typeof(terse_same_type.b)
@test typeof(fully_parameterized.a) |> isconcretetype
@test eltype(parameterized_subtyped.b) === typeof(parameterized_subtyped.c)
@test typeof(kwdef) |> isconcretetype

@test @capture_out(show(stdout, MIME("text/plain"), typeof(fully_parameterized))) == "FullyParameterized{typeof(sin)}"
@test @capture_out(show(stdout, FullyParameterized)) == "FullyParameterized"
@test @capture_out(show(stdout, hanging_type_param)) == "HangingTypeParam{true}(1, 2.0)"
@test @capture_out(show(stdout, MIME("text/plain"), ArgsTerse)) == "ArgsTerse"
