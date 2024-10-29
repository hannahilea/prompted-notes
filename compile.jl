using Pkg
Pkg.activate(@__DIR__)
using PackageCompiler

create_app("StallNotes", "StallNotesApp"; force=true,
           executables=["summarize" => "summarize_posts", "main" => "reflect_default"])
