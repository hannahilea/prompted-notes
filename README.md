# Prompted notes

Stall even harder by reflecting on why you're stalling! (Or let yourself be unblocked?!)

## Usage

Can be run from wherever, update run.jl to `path/to/run.jl` accordingly. Notes saved to `~/Desktop/stall-notes/`; update `DEFAULT_SAVE_DIR` to change path. 

Reflect on stalling:
```
$ julia run.jl
```

Summarize existing notes:
```
$ julia run.jl summarize
```

## Development 

Functionality lives in [`PromptedNotes.jl/src/PromptedNotes.jl`](PromptedNotes.jl/src/PromptedNotes.jl).

To compile the PromptedNotes.jl library to an app, do
```
$ julia --startup-file=no compile/run.jl 
```
The resultant app(s) (which can be relocated and double-clicked to launch the user's default terminal) will be generated in `PromptedNotesApp/bin`.

The `compile/_precompile.jl` file was created by starting a session via 
```
julia --project=. --trace-compile=compile/_precompile.jl  
``` 
and, in that session, running the `summarize` function in the main entrypoint. 
In the future this could be added as a compilation step; for now, it likely won't 
change significantly enough to regenerate regularly.

### Future dev 
- [ ] Write to file after each prompt
- [ ] Add trace-compile to build script
- [ ] Use default template(s) in output directory, otherwise use default
- [ ] Support multiple templates per directory
- [ ] Add docs
- [ ] Add badges to readme
- [ ] GHA build/artifacts?
- [ ] Summarize could do more---show stuff over time, etc? Or display all contents
- [ ] Try remaking in, e.g., Rust
