using Pkg
Pkg.activate(@__DIR__)
Pkg.resolve()
Pkg.instantiate()
using PromptedNotes

if abspath(PROGRAM_FILE) == @__FILE__
    if length(ARGS) == 0
        PromptedNotes.reflect_default()
    elseif length(ARGS) == 1 && contains(lowercase(first(ARGS)), "summar")
        PromptedNotes.summarize_posts()
    else
        @warn "Argument(s) `$ARGS` not supported; use no arguments to reflect, single `summary` to summarize"
    end
end
