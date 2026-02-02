# unlock mealie user accounts

You can either use an admin account to unlock the account, or...

Open a shell in the container:

```bash
docker exec -it mealie bash
```

Run this script:

```bash
python /opt/mealie/lib64/python3.12/site-packages/mealie/scripts/reset_locked_users.py
```

>[!warning] This will unlock **ALL** locked user accounts.
