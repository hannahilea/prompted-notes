# Stall notes

Stall even harder by reflecting on why you're stalling! (Or let yourself be unblocked?!)

## Usage

Can be run from wherever, update run.jl to path/to/run.jl accordingly. Notes saved to `~/Desktop/stall-notes/`; update `DEFAULT_SAVE_DIR` to change path. 

Reflect on stalling:
```
$ julia run.jl
```

Summarize existing notes:
```
$ julia run.jl summarize
```

Add a note after succeeding at a stalled task:
```
$ julia run.jl success
```

## Development 

Functionality lives in [`StallNotes/src/StallNotes.jl`](StallNotes/src/StallNotes.jl).

To compile StallNotes.jl library to an executable app, do
```
$ julia --startup-file=no compile.jl 
```
The resultant app (which can be double-clicked to launch the user's default terminal) will be generated in `StallNotesApp/bin`.

The `_precompile.jl` file was created by starting a session via 
```
julia --project=. --trace-compile=_precompile.jl  
``` 
and, in that session, running the functions in the main entrypoint. In the future this could be added to the compilation script.

### Future dev 
- [ ] Summarize could do more---show stuff over time, etc? Or display all contents
- [ ] Try remaking in, e.g., Rust!
- [ ] Rename library
- [ ] Add tests
- [ ] Run tests in CI 
- [ ] make public 
- [ ] CI build/artifacts?
- [ ] Use default template(s) in output directory, otherwise use default
- [ ] Support multiple templates per directory
- [ ] Add docs
- [ ] Add trace-compile to build script
- [ ] Write to file after each prompt
