module StallNotes

using Dates
const DEFAULT_SAVE_DIR = expanduser(joinpath("~", "Desktop", "stall-notes"))

function prompt_success(; dir=DEFAULT_SAVE_DIR)
    @warn "Not yet implemented!"
end


function prompt_reflection(; dir=DEFAULT_SAVE_DIR)
    date = now()
    filepath = joinpath(dir, "stall-$date.txt")
    while isfile(filepath)
        # Avoid race conditions for the same timestamp, although tbh those should be
        # unlikely for this program!
        date = now()
        filepath = joinpath(dir, "$date.txt")
    end
    @debug "Saving to $filepath"
    mkpath(dirname(filepath))

    open(filepath; append=true) do io
        ask! = (label, question; default="", required=false) -> begin
            a = Base.prompt(question; default)
            while required && isempty(a)
                a = Base.prompt(question; default)
            end
            write(io, "$label\t$a\n")
            return a
        end

        what = ask!("What", "What are you stalling on?"; required=true)
        ask!("When", "How long have you been stalling on $what?")
        ask!("Why", "Why are you stalling on $what?")
        ask!("Who", "Who is affected by you stalling on $what?")
        ask!("Step", "What is the smallest first step you could take towards $what?")
        ask!("Notes", "Anything else worth noting?"; default="N/A")
    end
    
    println("Thank you for your reflection!")
    println("/t-> Saved to `$(filepath)`")
    sleep(3)
    return nothing
end

function summarize(dir=DEFAULT_SAVE_DIR)
    stalls = length(filter(f -> startswith(f, "stall-"), readdir(dir)))
    successes = length(filter(f -> startswith(f, "success-"), readdir(dir)))
    @info "Summary:" stalls successes dir
    return nothing
end

function julia_main()::Cint
    println("Hi there! :)")
    if length(ARGS) == 0
        prompt_reflection()
    elseif length(ARGS) == 1 && contains(lowercase(first(ARGS)), "success")
        prompt_success()
    elseif length(ARGS) == 1 && contains(lowercase(first(ARGS)), "summar")
        summarize()
    else
        @warn "Argument(s) `$ARGS` not supported; use no arguments to reflect, single `success` to write a success note!"
    end
    return 0 # if things finished successfully
end

end # module StallNotes
