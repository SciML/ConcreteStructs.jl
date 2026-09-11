using ConcreteStructs, BenchmarkTools
using StableRNGs

const SUITE = BenchmarkGroup()
const rng = StableRNG(123)

@concrete struct BenchFieldStruct
    x
    y
    A
end

@concrete terse struct BenchTerse
    val
    grad
end

@concrete struct BenchParametric{T}
    data::T
    w
end

# =============================================================================
# Construction (the @concrete macro is compile-time; these measure the
# generated constructors)
# =============================================================================

SUITE["construct"] = BenchmarkGroup()

A = rand(rng, 100, 100)
SUITE["construct"]["plain"] = @benchmarkable BenchFieldStruct(1.0, 2.0, $A)
SUITE["construct"]["terse"] = @benchmarkable BenchTerse(1.0, $A)
SUITE["construct"]["parametric"] = @benchmarkable BenchParametric(
    $A, 1.0
)
SUITE["construct"]["small"] = @benchmarkable BenchFieldStruct(1, 2, 3)

# =============================================================================
# Field access on concretized structs
# =============================================================================

SUITE["access"] = BenchmarkGroup()

s = BenchFieldStruct(1.0, 2.0, A)
SUITE["access"]["getproperty"] = @benchmarkable $s.x
SUITE["access"]["fieldwork"] = @benchmarkable sum($s.A)
