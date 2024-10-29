using Test
using StallNotes
using Aqua

@testset "StallNotes.jl" begin
    @testset "Aqua" begin
        Aqua.test_all(StallNotes; ambiguities=false)
    end
end
