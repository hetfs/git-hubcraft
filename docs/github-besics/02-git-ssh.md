---
id: 02-git-ssh
title: 🔐 Git over SSH Keys
sidebar_position: 5
---

# 🔐 Git over SSH: Secure Authentication Guide

Use SSH for password-less, secure access to Git repositories. This comprehensive guide covers key generation, agent setup, GitHub configuration, testing, key rotation, multiple account management, and optional automation with Ansible.

## Prerequisites
* Git installed on your system
* GitHub account access
* Basic terminal/command line familiarity

---

## 🔑 Setting Up GitHub SSH Authentication

GitHub recommends **SSH keys** over HTTPS with passwords or tokens for enhanced security. Follow these steps to generate and configure a modern Ed25519 SSH key.

---

## 1. Generate a Modern SSH Key Pair

```bash
ssh-keygen -t ed25519 -C "your_github_username@github" -f ~/.ssh/id_ed25519
```

**Command Breakdown:**
* `-t ed25519` → Specifies the **Ed25519 algorithm** (more secure and efficient than RSA)
* `-C "..."` → Adds an identifying comment (typically your GitHub username/email)
* `-f ~/.ssh/id_ed25519` → Saves keys to specified location

**Generated Files:**
* `~/.ssh/id_ed25519` → **Private key** (keep secure!)
* `~/.ssh/id_ed25519.pub` → **Public key** (safe to share)


💡 *You'll be prompted for your passphrase once per session*

---

## 🔑 Example: Generating a key with a passphrase

Perfect 👌—this is a really useful addition because many people skip over what a **passphrase** actually means in SSH key generation. Understand how to generate a key **with a passphrase**, why it matters, and what the prompts look like.

When you run the command:

```bash
ssh-keygen -t ed25519 -C "hetfs@gmail.com" -f ~/.ssh/HETFS
```

You’ll see an interactive prompt like this:

```bash
Generating public/private ed25519 key pair.
Created directory '/home/binahf/.ssh'.
Enter passphrase for "/home/binahf/.ssh/HETFS" (empty for no passphrase): 
Enter same passphrase again: 
Your identification has been saved in /home/binahf/.ssh/HETFS
Your public key has been saved in /home/binahf/.ssh/HETFS.pub
The key fingerprint is:
SHA256:RCPT6N2IhnDQqOWb8MvYPneFSGxqFwJnk3bXOcp4w38 hetfs@gmail.com
The key's randomart image is:
+--[ED25519 256]--+
|  .=  o+o.       |
|. X + o+=.       |
| O * B +.+       |
|o o B X.o .      |
| o B = +S        |
|  * o . o E      |
| = o   . .       |
|. = . .          |
| ..o .           |
+----[SHA256]-----+
```

### 📝 Notes on passphrases

* If you **leave the passphrase empty**, your key works without any password prompt. This is convenient, but if someone steals your private key file, they can impersonate you immediately.
* If you **set a passphrase**, the private key is encrypted. You’ll be prompted for the passphrase the first time you use the key.
* To avoid retyping the passphrase every time, the **SSH agent** (`ssh-agent`) can cache it for your session or until you log out.

👉 **Best practice**: Always set a passphrase on your private key. Combine it with `ssh-agent` for convenience.

---

## 2. Start SSH Agent and Add Your Key

```bash
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

**Components:**
* `ssh-agent` → Manages SSH keys in the background
* `eval "$(ssh-agent -s)"` → Starts agent and sets environment variables
* `ssh-add` → Loads your private key into the agent

---

## 3. Add Public Key to GitHub

```bash
cat ~/.ssh/id_ed25519.pub
```

**Steps:**
1. Copy the entire output (starts with `ssh-ed25519 ...`)
2. Navigate to **GitHub → Settings → SSH and GPG keys → New SSH key**
3. Paste key, add descriptive title (e.g., "Work Laptop")
4. Save changes

📝 *You can use the same key across multiple devices or generate unique keys per machine*

---

## 4. Test Your SSH Connection

```bash
ssh -T git@github.com
```

**Expected Success Response:**
```
Hi <username>! You've successfully authenticated, but GitHub does not provide shell access.
```

✅ **Congratulations!** Git will now use SSH for all repository operations.

---


## 🖥️ Platform-Specific Instructions

### macOS / Linux
```bash
ssh-keygen -t ed25519 -C "your_github_username@github" -f ~/.ssh/id_ed25519
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
```

### Windows
**Option A: Git Bash** → Use same commands as macOS/Linux  
**Option B: PowerShell**
```powershell
ssh-keygen -t ed25519 -C "your_github_username@github" -f $env:USERPROFILE\.ssh\id_ed25519
Start-Service ssh-agent
ssh-add $env:USERPROFILE\.ssh\id_ed25519
```

🔒 **Security Best Practice:** Always use a passphrase for additional protection

---

## ⚙️ SSH Configuration Management

Create/update `~/.ssh/config` for improved workflow:

**Basic Configuration:**
```sshconfig
Host github.com
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519
  AddKeysToAgent yes
  IdentitiesOnly yes
```

**Multiple Identities:**
```sshconfig
Host github.com-personal
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_personal

Host github.com-work
  HostName github.com
  User git
  IdentityFile ~/.ssh/work_key
```

---

## 🔄 Key Rotation Procedure

1. **Generate** new key pair
2. **Add** new public key to GitHub
3. **Test** connection with new key
4. **Remove** old key from GitHub
5. **Delete** old private key from local system

---

## 👥 Multiple GitHub Accounts Setup

**Generate Separate Keys:**
```bash
# Personal account
ssh-keygen -t ed25519 -C "personal@github" -f ~/.ssh/id_ed25519_personal

# Work account
ssh-keygen -t ed25519 -C "work@github" -f ~/.ssh/id_ed25519_work
```

**Configure SSH:**
```sshconfig
Host github.com-personal
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_personal
  IdentitiesOnly yes

Host github.com-work
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_work
  IdentitiesOnly yes
```

**Update Repository Remotes:**
```bash
# Personal repository
git remote set-url origin git@github.com-personal:username/repo.git

# Work repository
git remote set-url origin git@github.com-work:organization/repo.git
```

---

## 🐛 Testing and Troubleshooting

**Diagnostic Commands:**
```bash
# Verbose connection test
ssh -vT git@github.com

# List loaded keys
ssh-add -l

# Check remote URLs
git remote -v

# Switch from HTTPS to SSH
git remote set-url origin git@github.com:OWNER/REPO.git
```

**Common Solutions:**
* Verify `IdentityFile` paths in SSH config
* Use `IdentitiesOnly yes` to prevent wrong key attempts
* Restart agent: `ssh-add -D` followed by `ssh-add ~/.ssh/your_key`

---

## 📧 Privacy Protection

SSH secures transport, but commit emails remain visible. To protect your email:

1. Enable **"Keep my email addresses private"** in GitHub settings
2. Use GitHub's provided noreply email:
```bash
git config --global user.email "12345678+youruser@users.noreply.github.com"
```

---

## 🤖 Automated Key Deployment with Ansible

**Requirements:**
* GitHub personal access token with `admin:public_key` scope
* Ansible collection: `community.general`

**Example Playbook:**
```yaml
- name: Upload SSH key to GitHub
  hosts: localhost
  vars:
    github_token: "{{ lookup('env', 'GITHUB_TOKEN') }}"
    github_key_title: "Dev Laptop ({{ ansible_hostname }})"
 
  tasks:
    - name: Ensure SSH key exists
      community.crypto.openssh_keypair:
        path: ~/.ssh/id_ed25519
        type: ed25519
        comment: "{{ ansible_user }}@github"
 
    - name: Read public key
      slurp:
        src: ~/.ssh/id_ed25519.pub
      register: public_key
 
    - name: Upload to GitHub
      community.general.github_key:
        token: "{{ github_token }}"
        title: "{{ github_key_title }}"
        pubkey: "{{ public_key.content | b64decode }}"
```

**Execution:**
```bash
export GITHUB_TOKEN=your_token_here
ansible-playbook deploy-key.yml
```

---

## 🔒 Security Recommendations

* ✅ Prefer **Ed25519** over RSA algorithms
* ✅ Always use strong passphrases
* ✅ Restrict key permissions: `chmod 600 ~/.ssh/private_key`
* ✅ Regularly rotate keys (every 6-12 months)
* ❌ Never commit private keys to repositories
* ❌ Avoid sharing private keys across devices

---

## ❓ Frequently Asked Questions

**Q: Can I convert my existing RSA key to Ed25519?**
A: No, generate a new Ed25519 key and add it to GitHub alongside your existing key.

**Q: Why does authentication fail with "Permission denied"?**
A: Check: 1) Key uploaded to GitHub, 2) Correct key loaded in agent, 3) Proper SSH config

**Q: Do I need a Personal Access Token with SSH?**
A: Only for API access. Git operations (clone/push/pull) work exclusively with SSH keys.

**Q: How often should I rotate my SSH keys?**
A: Every 6-12 months, or immediately if a device is compromised.

---

## 🚀 Getting Started with SSH

Clone repositories using SSH format:
```bash
git clone git@github.com:OWNER/REPOSITORY.git
```


## 📚 Official Documentation
* [Generating a new SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)
* [Adding SSH key to GitHub account](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/adding-a-new-ssh-key-to-your-github-account)
* [SSH Troubleshooting](https://docs.github.com/en/authentication/troubleshooting-ssh)

---

🎉 **You're now set up for secure, password-free Git operations!**
