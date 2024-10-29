using Pkg
Pkg.activate(@__DIR__)
using PackageCompiler

create_app("StallNotes", "StallNotesApp"; force=true,
           precompile_statements_file="_precompile.jl",
           executables=["summarize" => "summarize_posts", "main" => "reflect_default"])
