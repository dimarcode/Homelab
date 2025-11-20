# rsync commands

```bash
rsync -aAXHv --progress /source/ /destination/
```

## What each option does

- `-a` = archive mode (recursive, preserves permissions, ownership, timestamps, symlinks)
- `-A` = preserve ACLs
- `-X` = preserve extended attributes
- `-H` = preserve hard links
- `-v` = verbose (optional)
- `--progress` = show transfer progress (optional)
- `--delete` = sync deletions as well (e.g. mirror) (optional)