using Pkg
Pkg.activate(@__DIR__)
using PackageCompiler

create_app("StallNotes", "StallNotesApp"; force=true, incremental=true)
