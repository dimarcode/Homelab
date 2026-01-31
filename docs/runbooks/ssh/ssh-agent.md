# Start ssh-agent and add your key

## Windows

### Ensure the SSH Agent Service Is Running

In PowerShell (as **Administrator**):

```Powershell
Get-Service ssh-agent
```

If it’s not running:

- If you want it to start automatically:

```powershell
Set-Service ssh-agent -StartupType Automatic
```

- To start the service

```powershell
Start-Service ssh-agent
```

### Add Your Key to the Agent

In **normal PowerShell**:

```powershell
ssh-add $env:USERPROFILE\.ssh\id_ed25519
```

Verify:

```powershell
ssh-add -l
```

## Linux

Start ssh-agent:

```bash
eval "$(ssh-agent -s)"
```

Add private key to agent:

```bash
ssh-add ~/.ssh/id_ed25519
```

Verify:

```bash
ssh-add -l
```
