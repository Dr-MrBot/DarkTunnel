# DarkTunnel
DarkTunnel is a local-to-public URL and directory hosting tool that lets you host any local site or folder online and mask it with custom-looking URLs. 🌐 It offers 3 modes: native tunnel, masked links, and standalone disguise. Ideal for ethical hacking, testing, and link sharing. 🚀🔐


# 🌐 DarkTunnel - Local to Public URL & Masking Toolkit

![DarkTunnel](https://img.shields.io/badge/Tool-DarkTunnel-blueviolet?style=flat-square)
![Status](https://img.shields.io/badge/status-active-brightgreen)
![License](https://img.shields.io/badge/license-MIT-green)

> DarkTunnel is a local-to-public URL and directory hosting tool that also allows you to mask the URL with custom domains and phishing-style keywords. Useful for ethical hacking, cybersecurity training, and educational testing purposes. 🚀

---

## 🚀 Features

- 🌍 Host your local files/folders with public access
- 🎭 Mask URLs with fake-looking links (custom domain + keyword)
- 🔧 Choose from 3 working modes:
  - Native tunnel (coming soon)
  - Custom mask (user-defined keyword and domain)
  - Standalone masking (quick masking without tunneling)
- 💡 Easy-to-use terminal UI
- 🐍 Python & Shell script based

---

---

## 📸 Screenshot

> Main Interface Example

![DarkTunnel Screenshot](screenshots/ss.png)

> *(Save your terminal screenshot as `darktunnel-example.png` inside a `screenshots/` folder)*

---

## ⚙️ Installation (First-Time Setup)

```bash
# Clone the repository
git clone https://github.com/Dr-MrBot/DarkTunnel
cd DarkTunnel
pip install -r requrments.txt

# Make the main script executable
chmod +x DarkTunnel.sh

# Install required Python package
pip install pyshorteners

# Run Tool
./DarkTunnel.sh
