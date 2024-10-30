using Test
using PromptedNotes
using Aqua

const TESTCASE_DIR = joinpath(pkgdir(PromptedNotes), "test", "testcases")

@testset "PromptedNotes.jl" begin
    @testset "Aqua" begin
        Aqua.test_all(PromptedNotes; ambiguities=false)
    end

    @testset "template paths" begin
        using PromptedNotes: get_template_paths, get_single_template,
                             DEFAULT_TEMPLATE_DIR
        @test length(get_template_paths(joinpath(TESTCASE_DIR, "dir-double-template"))) == 2
        @test isequal(get_template_paths(mktempdir()),
                      get_template_paths(DEFAULT_TEMPLATE_DIR))

        @test isequal(get_single_template(mktempdir()),
        get_single_template(DEFAULT_TEMPLATE_DIR))

        dir = joinpath(TESTCASE_DIR, "dir-single-template")
        @test isequal(get_single_template(dir),
                      joinpath(dir, "ex.template.yaml"))
    end

    @testset "template loading" begin
        template_path = joinpath(PromptedNotes.DEFAULT_TEMPLATE_DIR,
                                 "default-stall.template.yaml")
        t = load_template(template_path)
        @test length(t.questions) == 6
        @test issetequal(keys(t), [:prefix, :questions, :opening, :closing])
    end
end
