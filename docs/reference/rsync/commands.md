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

## Important Notes:

**Trailing Slash:**
- The presence or absence of a trailing slash on the `SOURCE` path significantly impacts `rsync`'s behavior.
	- `/path/to/source/` (with trailing slash): Copies the contents of the `source` directory into the `destination`.
	- `/path/to/source` (without trailing slash): Copies the `source` directory itself into the `destination`.
