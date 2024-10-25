using Pkg
Pkg.activate(@__DIR__)
using StallNotes

if abspath(PROGRAM_FILE) == @__FILE__
    return StallNotes.julia_main()
end
