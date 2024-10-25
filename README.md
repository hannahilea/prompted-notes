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

From this directory, do 
```
$ julia compile.jl 
```

App (to double-click) will be generated in StallNotesCompiled/bin.
