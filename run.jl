using Pkg
Pkg.activate(@__DIR__)
Pkg.resolve()
Pkg.instantiate()
using StallNotes

if abspath(PROGRAM_FILE) == @__FILE__
    if length(ARGS) == 0
        StallNotes.reflect_default()
    elseif length(ARGS) == 1 && contains(lowercase(first(ARGS)), "summar")
        StallNotes.summarize_posts()
    else
        @warn "Argument(s) `$ARGS` not supported; use no arguments to reflect, single `summary` to summarize"
    end
end
