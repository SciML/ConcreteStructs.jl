using ConcreteStructs: _parse_head, _parse_struct_def, _parse_line
using ConcreteStructs: _strip_super, _get_subparams, _get_constructor_params
using Test

# Test setup
line_number_node = LineNumberNode(1)
annotated_abstract = :(b::AbstractFloat)
annotated_concrete = :(b::Float64)
struct_name = :(MyStruct)
sub_typed_params = :(MyStruct{T1, T2 <: AbstractVector{T1}})
sub_typed = :(MyStruct{D} <: Number)
kitchen_sink = :(MyStruct{T1, T2 <: AbstractVector{T1}} <: AbstractVector{T1})
plain_assignment = :(a = 1)
annotated_assignment = :(a::Float64 = 2.0)
subtype_annotated_assignment = :(a <: Real = 2.0)

@testset "_parse_line" begin
    @test _parse_line(line_number_node) == (line_number_node, nothing)
    # @test _parse_line(annotated_abstract)[1].args[2] != :AbstractFloat
    # @test _parse_line(annotated_abstract)[2].args[2] == :AbstractFloat
    @test _parse_line(annotated_concrete)[1].args[2] == :Float64
    @test _parse_line(annotated_concrete)[2] === nothing

    parsed_sym = _parse_line(:a)
    @test parsed_sym[1].args[2] == parsed_sym[2]

    @test _parse_line(plain_assignment)[1].head == :(=)
    @test _parse_line(plain_assignment)[1].args[1].args[2] == _parse_line(plain_assignment)[2]
    @test _parse_line(annotated_assignment)[1].head == :(=)
    @test _parse_line(annotated_assignment)[2] === nothing
    @test _parse_line(subtype_annotated_assignment)[1].head == :(=)
    @test _parse_line(subtype_annotated_assignment)[2].args[2] == :Real
end

@testset "_parse_struct_def" begin
    @test _parse_struct_def(struct_name) == (struct_name, [])
    @test _parse_struct_def(sub_typed_params) == (struct_name, [:T1, :(T2 <: AbstractVector{T1})])
end

@testset "_parse_head" begin
    @test _parse_head(struct_name) == (struct_name, [], :Any)
    @test _parse_head(sub_typed) == (struct_name, Any[:D], :Number)
    @test _parse_head(kitchen_sink) == (struct_name, [:T1, :(T2 <: AbstractVector{T1})], :(AbstractVector{T1}))
end

@testset "_strip_super" begin
    @test _strip_super(struct_name) == struct_name
    @test _strip_super(kitchen_sink) == :(MyStruct{T1, T2 <: AbstractVector{T1}})
    @test _strip_super([struct_name, sub_typed]) == [struct_name, :(MyStruct{D})]
end

@testset "_get_subparams" begin
    @test _get_subparams(struct_name) == []
    @test _get_subparams([:T1, :(T2 <: AbstractArray{T1, N}), :(T3 <: Complex{T1})]) == Any[:T1, :N, :T1]
end

@testset "_get_constructor_params" begin
    @test _get_constructor_params([:T, :(A <: AbstractVector{T})], [:A, :B]) == []
    @test _get_constructor_params([:iip, :T, :(A <: AbstractVector{T})], [:A, :B]) == [:iip]
    @test _get_constructor_params([:iip, :T, :(A <: AbstractVector{T}), :B], [:B]) == [:iip, :A]
end
