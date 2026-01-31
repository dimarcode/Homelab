# install terraform

Go to [[https://developer.hashicorp.com/terraform/install#linux]] and download for your specific CPU architecture:

- Copy link address for achitecture

```bash
cd ~ && wget <paste-download-url-here>
```

- Unzip the package (must have unzip installed)

```bash
unzip <name-of-package>
```

- Change permissions of terraform install

```bash
sudo chown root:root terraform
```

- Move to /usr/local/bin

```bash
sudo mv terraform /usr/local/bin
```

- Test correct directory

```bash
command -v terraform
```

- Should print /usr/local/bin/terraform
