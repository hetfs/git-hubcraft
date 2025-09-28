---
id: 02-git-ssh
title: 🔐 Git over SSH Keys
sidebar_position: 5
---

# 🔐 Git over SSH: Secure Authentication Guide

SSH keys let you connect to GitHub and other Git remotes securely without typing your password each time. This guide covers everything from generating keys to advanced multi-account setups and automation.

---

## 📦 Prerequisites

- ✅ Git installed on your system
- ✅ A GitHub account
- ✅ Basic familiarity with the terminal or command line

---

## 🖥️ Platform-Specific Setup

### macOS / Linux
```bash
ssh-keygen -t ed25519 -C "your_github_username@github" -f ~/.ssh/id_ed25519
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
````

### Windows

**Option A: Git Bash** → Use the same commands as Linux/macOS.

**Option B: PowerShell with OpenSSH**

```powershell
ssh-keygen -t ed25519 -C "your_github_username@github" -f $env:USERPROFILE\.ssh\id_ed25519
Start-Service ssh-agent
ssh-add $env:USERPROFILE\.ssh\id_ed25519
```

---

## 1️⃣ Generate a Modern SSH Key Pair

```bash
ssh-keygen -t ed25519 -C "your_github_username@github" -f ~/.ssh/id_ed25519
```

### Command breakdown

* `-t ed25519` → Uses the **Ed25519 algorithm** (modern, secure, fast)
* `-C "..."` → Adds a helpful comment (usually your GitHub email or username)
* `-f ~/.ssh/id_ed25519` → Sets the save location for your keys

### Output files

* `~/.ssh/id_ed25519` → **Private key** (never share this)
* `~/.ssh/id_ed25519.pub` → **Public key** (safe to upload)

---

## 🔑 Using a Passphrase

When generating your key, you’ll see:

```bash
Generating public/private ed25519 key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
```

* **Empty passphrase** → Faster, but unsafe (if your private key leaks, anyone can use it).
* **With passphrase** → Your private key is encrypted. You’ll type it the first time you use it, then `ssh-agent` can cache it.

### Example with passphrase

```bash
ssh-keygen -t ed25519 -C "hetfs@gmail.com" -f ~/.ssh/HETFS
```

Prompt example:

```
Enter passphrase for "/home/binahf/.ssh/HETFS":
Enter same passphrase again:
Your identification has been saved in /home/binahf/.ssh/HETFS
Your public key has been saved in /home/binahf/.ssh/HETFS.pub
```

**Best Practice:** Always set a passphrase. It protects you if your key is ever stolen.
💡 Use `ssh-agent` so you only type it once per session.

---

## 2️⃣ Start SSH Agent and Add Your Key

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

* `ssh-agent` → Background program that holds your keys
* `ssh-add` → Loads your key into the agent (caches passphrase if needed)

---

## 3️⃣ Add Public Key to GitHub

1. Copy your key:

   ```bash
   cat ~/.ssh/id_ed25519.pub
   ```

   Or use clipboard helpers:

   ```bash
   cat ~/.ssh/id_ed25519.pub | xclip -sel clip   # Linux (X11)
   cat ~/.ssh/id_ed25519.pub | wl-copy           # Linux (Wayland)
   cat ~/.ssh/id_ed25519.pub | pbcopy            # macOS
   ```

2. Go to [**GitHub → Settings → SSH and GPG keys**](https://github.com/settings/keys)
   → **New SSH Key** → Give it a descriptive name → Paste your key

---

## 🗝️ User Keys vs Deploy Keys

**User SSH Key** → Tied to your GitHub **account**. Works across all repos you can access.
**Deploy Key** → Tied to **one repository**. Great for CI/CD, servers, or automation.

| Aspect    | User Key (✅ Devs)        | Deploy Key (✅ Automation)   |
| --------- | ------------------------ | --------------------------- |
| Scope     | All repos you can access | Only 1 repo                 |
| Added in  | Account Settings         | Repo Settings → Deploy Keys |
| Use Case  | Daily developer work     | CI/CD, servers              |
| Key reuse | One key for all          | One key per repo            |

👉 For personal use: **always add keys as a User SSH Key.**
👉 For servers/automation: **use Deploy Keys.**

---

## 4️⃣ Test Your SSH Connection

```bash
ssh -T git@github.com
```

Expected:

```
Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.
```

✅ If you see this, your SSH setup works.

---

## 🔀 Switching Remote from HTTPS to SSH

Check your current remote:

```bash
git remote -v
```

Switch to SSH:

```bash
git remote set-url origin git@github.com:USERNAME/REPO.git
```

Verify:

```bash
git remote -v
# origin  git@github.com:USERNAME/REPO.git (fetch)
# origin  git@github.com:USERNAME/REPO.git (push)
```


<details>
<summary>🔄 Example: Change Git Remote URL from HTTPS to SSH</summary>

To switch from HTTPS to SSH, you’ll need to update the `origin` remote URL in your repository.

---

## 1️⃣ Check Your Current Remote URL
Run:
```bash
git remote -v
````

Example output:

```
origin  https://github.com/hetfs/CrossOS.git (fetch)
origin  https://github.com/hetfs/CrossOS.git (push)
```

---

## 2️⃣ Update the Remote URL to SSH

Use the SSH format: `git@github.com:username/repository.git`.

```bash
git remote set-url origin git@github.com:hetfs/CrossOS.git
```

---

## 3️⃣ Verify the Change

Run again:

```bash
git remote -v
```

Now you should see:

```
origin  git@github.com:hetfs/CrossOS.git (fetch)
origin  git@github.com:hetfs/CrossOS.git (push)
```

---

## ✅ Step 5: Test Your SSH Connection

Make sure authentication works:

```bash
ssh -T git@github.com
```

Expected message:

```
Hi hetfs! You've successfully authenticated, but GitHub does not provide shell access.
```

This confirms your SSH setup is working correctly.

---

## 🎉 All Set!

From now on, `git push` will use SSH instead of HTTPS.
If your key has a passphrase, you’ll be prompted the first time. Most systems can remember it via your OS keychain or SSH agent.

</details>

---

## ⚙️ SSH Config File

For convenience, edit `~/.ssh/config`:

```sshconfig
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
  AddKeysToAgent yes
  IdentitiesOnly yes
```

## Multiple accounts

```sshconfig
Host github.com-personal
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_personal

Host github.com-work
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_work
```

Then set per-repo remotes:

```bash
git remote set-url origin git@github.com-work:org/repo.git
```

---

## 🔄 Key Rotation

1. Generate a new key pair
2. Add the new public key to GitHub
3. Test it
4. Remove old key from GitHub
5. Delete old key file locally

---

## 🐛 Debugging Tips

```bash
ssh -vT git@github.com   # verbose connection test
ssh-add -l               # list loaded keys
git remote -v            # check repo URLs
```

Common fixes:

* Wrong key? Fix `IdentityFile` in `~/.ssh/config`
* Too many keys? Use `IdentitiesOnly yes`
* Restart agent: `ssh-add -D && ssh-add ~/.ssh/your_key`

---

## 📧 Commit Email Privacy

SSH hides your transport, **not your Git identity**.
Use GitHub’s noreply email if you want privacy:

```bash
git config --global user.email "12345678+youruser@users.noreply.github.com"
```

Enable in **GitHub → Settings → Emails → Keep my email address private**.

---

## 🔒 Security Best Practices

* ✅ Prefer **Ed25519**
* ✅ Use strong passphrases
* ✅ `chmod 600 ~/.ssh/private_key`
* ✅ Rotate keys every 6–12 months
* ❌ Never share or commit private keys

---

## ❓ FAQ

**Q: Can I convert RSA → Ed25519?**
A: No. Generate a new Ed25519 key.

**Q: Why “Permission denied”?**
A: Check: correct key in agent, uploaded to GitHub, `~/.ssh/config` points to it.

**Q: Do I need a PAT if I use SSH?**
A: Not for Git push/pull/clone. Only needed for API access.

---

## 📚 References

* [Generate a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
* [Add SSH key to GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
* [Troubleshoot SSH](https://docs.github.com/en/authentication/troubleshooting-ssh)

---

🎉 You’re now set up for **secure, password-free Git operations**. Happy coding!

