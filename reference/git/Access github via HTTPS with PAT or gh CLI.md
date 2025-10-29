# Access github via HTTPS with PAT or gh CLI

- Create a Personal Access Token (PAT) on GitHub with repo scope (Settings → Developer settings → Personal access tokens).

## Option A: use gh CLI to login (it configures credential helper):

### interactive login (opens browser)

```bash
gh auth login
```

### then push normally

```bash
cd ~/Homelab
git push
```

## Option B: use PAT manually (one-time input or credential helper):

### configure a safer credential helper (avoid plain text store)

```bash
git config --global credential.helper cache
```

### on next git push, use your GitHub username and the PAT as the password when prompted

```bash
git push
```
