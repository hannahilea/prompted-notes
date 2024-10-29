module StallNotes

export load_template, prompt_template

using Dates
using WordCloud
using ImageInTerminal
using OrderedCollections
using YAML

const DEFAULT_SAVE_DIR = expanduser(joinpath("~", "Desktop", "stall-notes"))

# TODO-future: define Template as Legolas type; load accordingly; will remove many of the 
# various safety-checks here 
function load_template(template_path)
    template = YAML.load_file(template_path; dicttype=OrderedDict{String,Any})
    prefix = get(template, "prefix", "")
    questions = let
        q = get(template, "questions", [])
        filter(x -> !isempty(get(x, "prompt", "")), q)
    end
    isempty(questions) &&
        throw(ArgumentError("No `questions` found for template $(template_path)"))

    if any(q -> isempty(get(q, "label", "")) || isempty(get(q, "prompt", "")), questions)
        throw(ArgumentError("Questions must have non-empty labels and prompts: $(questions)"))
    end

    if length(questions) != length(Set([lowercase(get(q, "label", "")) for q in questions]))
        throw(ArgumentError("Question labels must be unique (case invariant): $(questions)"))
    end

    opening = get(template, "opening-comment", "Hello, note-taker!")
    closing = get(template, "closing-comment", "Thank you!")
    return (; prefix, questions, opening, closing)
end

# Note: not doing any yaml validation; if the template file is set up wrong, oh well, game over!
function prompt_template(dir; template_path)
    # Get input template 
    (; prefix, questions, opening, closing) = load_template(template_path)

    println()
    println(repeat("* ", 9))
    println(opening)

    # Set up output file
    date = now()
    filepath = joinpath(dir, "$prefix-$date.yaml")
    while isfile(filepath)
        # Avoid overwriting an existing timestamp
        # Could still run into race condition BUT that is very unlikely 
        # unless multiple people writing to same dir; that is a future-user problem!
        date = now()
        filepath = joinpath(dir, "$date.txt")
    end
    @debug "Saving to $filepath"
    mkpath(dirname(filepath))

    # Run questionaire
    responses = OrderedDict()
    for question in questions
        label = question["label"]
        prompt = replace_braces(question["prompt"], responses)
        default = get(question, "default", "")
        required = get(question, "required", false)
        @debug "QUESTION" label prompt default question

        responses[label] = Base.prompt(prompt; default)
        while required && isempty(responses[label])
            responses[label] = Base.prompt(prompt; default)
        end
        YAML.write_file(filepath, responses)
    end

    println(closing)
    println("  -> Saved to `$(filepath)`")
    println(repeat("* ", 9))
    println()
    return nothing
end

function replace_braces(str, dict)
    contains(str, "{{ ") || return str
    for k in keys(dict)
        str = replace(str, "{{ $k }}" => dict[k])
    end
    return str
end

function prompt_reflection(; dir=DEFAULT_SAVE_DIR)
    prompt_template(dir;
                    template_path=joinpath(pkgdir(StallNotes), "templates",
                                           "default-stall-template.yaml"))
    return nothing
end

function wordcloud_from_posts(paths::AbstractVector{<:AbstractString})
    lines = map(paths) do p
        answers = YAML.load_file(p; dicttype=OrderedDict)
        return join([v for v in values(answers)], "\n")
    end
    words = join(lines, "\n")

    # See https://github.com/guo-yong-zhi/WordCloud-Gallery/blob/main/README.md 
    # for styling options
    wc = paintcloud(words)
    display(wc)
    return wc
end

function summarize(dir::AbstractString)
    println("Analyzing posts in $dir...")
    # Assuming that the date is between 2000 and 2099! Not future proof past then :D 
    paths = filter(f -> contains(f, "-20") && endswith(f, ".yaml"), readdir(dir))
    prefixes = Set(first.(split.(paths, "-20"; limit=2)))

    summary = OrderedDict{AbstractString,Integer}()
    for prefix in prefixes
        subset = filter(p -> startswith(p, prefix), paths)
        summary[prefix] = length(subset)
        wordcloud_from_posts(map(p -> joinpath(dir, p), subset))
    end
    counts = join(["  $k: $v" for (k, v) in summary], "\n")
    @info "Summary:\n$counts" dir
    return nothing
end

function reflect_default()::Cint
    prompt_reflection(; dir=DEFAULT_SAVE_DIR)
    println("(Hit `Enter` to close)")
    readline()
    return 0 # if things finished successfully
end

function summarize_posts()::Cint
    summarize(DEFAULT_SAVE_DIR)
    println("(Hit `Enter` to close)")
    readline()
    return 0 # if things finished successfully
end

end # module StallNotes
