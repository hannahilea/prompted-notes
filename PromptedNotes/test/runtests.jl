using Test
using PromptedNotes
using Aqua

@testset "PromptedNotes.jl" begin
    @testset "Aqua" begin
        Aqua.test_all(PromptedNotes; ambiguities=false)
    end

    @testset "Basic" begin
        template_path = joinpath(pkgdir(PromptedNotes), "templates",
                                 "default-stall-template.yaml")
        t = load_template(template_path)
        @test length(t.questions) == 6
        @test issetequal(keys(t), [:prefix, :questions, :opening, :closing])
    end
end
