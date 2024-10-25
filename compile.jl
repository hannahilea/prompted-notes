using Pkg
Pkg.activate(@__DIR__)
using PackageCompiler

create_app("StallNotes", "StallNotesCompiled"; force=true)
