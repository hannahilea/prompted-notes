using Pkg
Pkg.activate(@__DIR__)
Pkg.instantiate()
using PackageCompiler

create_app(joinpath(@__DIR__, "..", "PromptedNotes.jl"),
           joinpath(@__DIR__, "..", "PromptedNotesApp"); force=true,
           precompile_statements_file="_precompile.jl",
           executables=["summarize" => "summarize_posts", "main" => "reflect_default"])
