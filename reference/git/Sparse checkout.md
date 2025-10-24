# Sparse checkout

[https://git-scm.com/docs/git-sparse-checkout](https://git-scm.com/docs/git-sparse-checkout)

## Create sparse checkout (only pull/sync specific files)

### 1. Enable sparse checkout:

```bash
git sparse-checkout init
```

### 2. Define which files or directories to include:

- Edit the `.git/info/sparse-checkout` file and add patterns for the files and directories you want in your working directory.
- Example patterns:

```bash
/docker-compose/karakeep-app/
/docker-compose/immich/
```

### 3. Applied the sparse checkout

```bash
git sparse-checkout reapply
```

Alternatively, you may have used the command-line interface to set the patterns:

```bash
git sparse-checkout set <path1> <path2> ...
```

## Add files to sparse checkout:

### 1. Edit your sparse-checkout file

Open `.git/info/sparse-checkout` and add the paths for the files or directories you want to include. 

For example:

```bash
/docker-compose/immich/.env.example
/docker-compose/immich/hwaccel.ml.yml

```

etc...

### 2. Update your working directory

After editing the sparse-checkout file, update your working directory:

```bash
git sparse-checkout reapply
```

### 3. Add the files

Now you can add the files:

```bash
git add .
```

>[!important] 
>
>**Alternative:**
>
>You can also use the `--sparse` option to add files outside your sparse-checkout definition:

```bash
git add --sparse <path-to-file>
```

## Remove the sparse checkout altogether:

To remove sparse checkout and restore all files in your working directory, run:

```bash
git sparse-checkout disable
```

Then update your working directory with:

```bash
git checkout main
```

This will make all files in the repository visible and available for staging, committing, and editing.
