---
title: Backup your data to B2 with restic and Backrest | LinuxServer.io
source: https://www.linuxserver.io/blog/backup-your-data-to-b2-with-restic-and-backrest
author:
  - Josh Stark
published: 2025-04-19
created: 2026-02-04
description:
tags:
  - clippings
---

SOURCE: Clipped from https://www.linuxserver.io/blog/backup-your-data-to-b2-with-restic-and-backrest written by Josh Stark and originally published 19th-April-2025. I followed their instructions exactly, but I shortened their article.

# Backup your data to B2 with restic and Backrest  LinuxServer.io

First:
[Configure backrest](Configure%20backrest.md)

### Create a Backblaze B2 bucket

![](assets/Backup%20your%20data%20to%20B2%20with%20restic%20and%20Backrest%20-%20LinuxServer.io/file-20260204224815210.png)

In the admin panel of your account, create a new bucket: give it a name, and keep it private. This will be where your backups are stored.

- Files in bucket are: **Private**
- Default Encryption: **Disable** (we will let restic deal with encryption)
- Object Lock: **Disable**

#### Create an application key

Under the **Application keys** menu, add a new key:

![](assets/Backup%20your%20data%20to%20B2%20with%20restic%20and%20Backrest%20-%20LinuxServer.io/file-20260204231656809.png)

- Allow access to Bucket(s): either left blank for all bucket access, or your bucket
	- If you do specify a bucket, make sure to check `Allow List All Bucket Names`
- Type of Access: **Read and Write**
- Everything else left blank

Creation of this new key will create three values: **keyID**, **keyName** and **applicationKey**.

> [!important]
> You will need to save *keyID* and *applicationKey*, as these represent your `aws_access_key_id` and `aws_secret_access_key`, respectively.

### Create a restic repository

Now, back to Backrest. You've got somewhere for backups to go, so now we need to tell restic how to connect to it. This is achieved through the Repository system. Click on **Add Repo** in Backrest, and fill in the following:

![](assets/Backup%20your%20data%20to%20B2%20with%20restic%20and%20Backrest%20-%20LinuxServer.io/file-20260204225333453.png)

- Repo name: whatever you want
- Repository URI: **`s3:s3.[YOUR_REGION].backblazeb2.com/[YOUR_BUCKET_NAME\]`**.
	- B2's URI for your buckets will be defined on the web portal where your buckets are listed. 
	- You need to use this as the base URI, with a suffix of your bucket name.
- Password: **Generate**
	- this will create a seed for data encryption. It is worth saving this somewhere in case you ever need to decrypt your data from another restic instance.
- Env vars: **Set Environment Variable**:

```yaml
AWS_SHARED_CREDENTIALS_FILE=/config/backblaze-credentials
```

- Prune Policy: I've set to once a month
- Check Policy: I've set to run every Sunday

Leave everything else blank/unchanged.

#### backblaze-credentials

Make a new file in `/opt/appdata/backrest/config` called `backblaze-credentials`

```bash
sudo nano /opt/appdata/backrest/config/backblaze-credentials
```

Add the following lines (change the values)

```bash
[default]
aws_access_key_id=<your_keyID>
aws_secret_access_key=<your_applicationKey>
```

Hit **Test Configuration** and you should see a confirmation message at the top of the screen:

![](assets/Backup%20your%20data%20to%20B2%20with%20restic%20and%20Backrest%20-%20LinuxServer.io/file-20260204225313636.png)

If you don't see this:
- Double-check the file permissions on your credentials file
- That it's in the right directory

**Save** your repository, and you should see it in the left-hand menu.
