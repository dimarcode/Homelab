
# Permission denied (publickey)

## Error

```bash
user@terminal:~$ git push -u origin main
git@github.com: Permission denied (publickey).
fatal: Could not read from remote repository.
```

This means that either your ssh key wasn't added to your local ssh agent, or the key is not yet stored in github.
## Potential Fix (add key to local agent)

### 1. Check if the ssh agent is running and if your key is already added by listing loaded SSH keys:

Run this command:

```
ssh-add -l
```
### 2. Start the SSH agent

Run this command:

```bash
eval "$(ssh-agent -s)"
```

You should see something like:

```bash
Agent pid 1234
```

### 3. Add your private SSH key

Now that the agent is running, load your key:

```bash
ssh-add ~/.ssh/id_ed25519
```

> [!note]
> If your key is named something else (like `id_rsa`), substitute accordingly.