# Initialize and Push a New Git Repository to GitHub (Linux)

This guide walks you through creating a new Git repository on Linux and pushing it to GitHub for the first time.

---

## Prerequisites

- [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
	- Check if already installed with `git --version`
- (Recommended) [Generate SSH Key for Remote Github Access](Generate%20SSH%20Key%20for%20Remote%20Github%20Access.md)

- Git installed (`git --version`)
- A GitHub account
- (Recommended) An SSH key added to your GitHub account

### Generate an SSH key (if you don't have one):

```bash
ssh-keygen -t ed25519 -C "your_email@example.com"
```

### Add your public key to GitHub:

```bash
cat ~/.ssh/id_ed25519.pub
```

- Copy the output and paste it into [GitHub SSH Settings](https://github.com/settings/ssh/new)

## Steps to Create and Push a New Git Repository

### 1. Create a new project folder and initialize Git

```bash
mkdir my-project
cd my-project
git init
```

---

### 2. Create your first file and make an initial commit

```bash
echo "# My Project" > README.md
git add README.md
git commit -m "Initial commit"
```

---

### 3. Create a new repository on GitHub

- Go to: [https://github.com/new](https://github.com/new)
- Name your repo (e.g., `my-project`)
- **Do not** initialize it with a README, license, or `.gitignore` (since you already created one)

---

### 4. Link your local repository to GitHub

If using SSH:

```bash
git remote add origin git@github.com:your-username/my-project.git
```

If using HTTPS:

```bash
git remote add origin https://github.com/your-username/my-project.git
```

### 5. Push your code to GitHub

```bash
git branch -M main   # Rename default branch to 'main' (if not already)
git push -u origin main
```
