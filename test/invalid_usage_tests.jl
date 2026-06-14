using ConcreteStructs
using Test

# `@concrete` applied to something that is neither a struct definition nor a
# macrocall wrapping one reaches `_find_struct_def`'s fallthrough, which must
# raise a clear `ErrorException` (previously a `nerror` typo made this throw
# an `UndefVarError` instead).
@test_throws "Invalid usage of @concrete." @macroexpand(@concrete x = 1)
