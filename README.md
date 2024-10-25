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
$ julia compile.jl 
```
The resultant app (which can be double-clicked to launch the user's default terminal) will be generated in `StallNotesApp/bin`.

### Future dev 
- [ ] Add "success" whatever
- [ ] Use [WordCloud.jl](https://github.com/guo-yong-zhi/WordCloud.jl) to show contents of notes 
- [ ] Summarize could do more---show stuff over time, etc? Or display all contents
- [ ] Generate question fields from a template (i.e., generic enough to support success/stall/other)
- [ ] Try remaking in, e.g., Rust!
