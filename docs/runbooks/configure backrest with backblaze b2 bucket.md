# configure backrest with backblaze b2 bucket

Saved from https://www.linuxserver.io/blog/backup-your-data-to-b2-with-restic-and-backrest for future reference

## Create a bucket in Backblaze UI

## Add an application key to access that bucket

B2 Cloud Storage > Application keys > Add a New Application Key

Configure with the following options:
- Name of Key
- Bucket you want to allow access to
- Type of Access: Read and Write
- Allow List All Bucket Names: Checked

> [!important]
> Take note of the values generated: **keyID**, **keyName**, and **applicationKey**. Store all of these somewhere secure, but make sure you have the **keyID** and **keyName** accessible for the next step.

## Create AWS S3 credentials file

### Create file in /config directory to store credentials

Purpose:
- Store AWS S3 credentials on a secure file on the server, instead of within the environment

Requires:
- **keyID** and **keyName** generated earlier
	- `keyID` corresponds with `aws_access_key_id`
	- `keyName` corresponds with `aws_secret_access_key`

Create credentials file in /config directory mounted to container. In this example, I have `/opt/appdata/backrest/config` mounted to `/config` in the container, so I will run these commands in `/opt/appdata/backrest/config`:

```bash
sudo nano backblaze-credentials
```

Then I will add the following lines:

```bash
[default]
aws_access_key_id=<your-keyID>
aws_secret_access_key=<your-bucketName>
```

Save this file, and then move on to the Backrest UI.

> [!important]
> Make sure this file has the necessary permissions to be read by the container UID and GID

## Add repo in Backrest

Home screen > + Add Repo

Configure with the following info:

| Name           | Value                                                            |
| -------------- | ---------------------------------------------------------------- |
| Repo Name      | Can be whatever you want                                         |
| Repository URL | `s3.[your region].backblazeb2.com/your-bucket-name`              |
| Password       | Secure password for the repo                                     |
| Env Vars       | `AWS_SHARED_CREDENTIALS_FILE=/config/<name of credentials file>` |
Example:
