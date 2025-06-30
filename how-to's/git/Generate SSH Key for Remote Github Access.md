# Generate SSH key for github access

[Connecting to GitHub with SSH](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)
### Generate an SSH key (if you don't have one):

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```
### Add your public key to GitHub:

```bash
cat ~/.ssh/id_ed25519.pub
```

- Copy the output and paste it into [GitHub SSH Settings](https://github.com/settings/ssh/new)