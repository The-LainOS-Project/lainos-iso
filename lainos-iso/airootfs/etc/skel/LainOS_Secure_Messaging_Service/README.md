# LainOS Secure Chat — XMPP over Tor

https://gitlab.com/lainos/lainos-onion-xmpp-server-guide

Welcome to the **LainOS Secure Chat Server Guide** — a privacy‑focused, cross‑platform messaging framework using XMPP and the Tor network.

---

## 🌐 What is this?

**LainOS Secure Chat** is a private, anonymous chat system built on:

* **XMPP (Extensible Messaging and Presence Protocol)** — decentralized real‑time messaging (including group chat/MUC).
* **Tor (.onion hidden service)** — anonymizes traffic and hides both user IPs and server locations.
* **Profanity client** — a lightweight terminal XMPP client used in this guide.
* **PGP Integrated with GNU pass** — anonymized pgp keys for seamless user authentication and storage of plaintext passphrases.
* **TLS** — for server authentication and encryption in transit.
Together these provide encrypted, anonymous messaging with resistance to surveillance and censorship. For end‑to‑end confidentiality, enable client‑side encryption (OMEMO or PGP).

This project is part of the [vesme‑avf repo](https://gitlab.com/amnesia1337/vesme-avf) and integrates secure comms into LainOS.

---

## 🔐 Server Details

* **My XMPP JID (example):**
  `amnesia1337@glcuf4hcwbm3lt6grg7jfwwus7sqpuojozfsnbzzcsf7vbm2jcfqckid.onion`

* **Server Address:**
  `glcuf4hcwbm3lt6grg7jfwwus7sqpuojozfsnbzzcsf7vbm2jcfqckid.onion`

* **LainOS Chatroom (MUC):**
  `private-chat-c75bebbc-50f3-447d-811f-41f83de11811@conference.glcuf4hcwbm3lt6grg7jfwwus7sqpuojozfsnbzzcsf7vbm2jcfqckid.onion`

---

## 🧰 Prerequisites(LainOS has them)

* `tor` (configured with **obfs4** bridges on LainOS)
* `torsocks`
* `profanity` XMPP client
* `KeePassXC` (recommended) to store credentials safely

---

## 🚀 How to Get Started

### 1. Start Tor with obfs4 support

```bash
sudo systemctl start tor
sudo systemctl status tor   # confirm it bootstraps to 100%
# optional logs: sudo journalctl -u tor -f
```

### 2. Launch Profanity via Tor

```bash
torsocks profanity
```

### 3. Register a new XMPP account

In the profanity prompt:

```profanity
/register yourusername glcuf4hcwbm3lt6grg7jfwwus7sqpuojozfsnbzzcsf7vbm2jcfqckid.onion
```

* Enter your password **twice**.
* **Password rules (server):** uppercase, lowercase and numbers only — **no special characters**.
  (Special characters are rejected by the server and/or may be interpreted by the terminal.)
* When asked about TLS:

```profanity
/tls allow
```

* Save your preferences:

```profanity
/save
```
 Then exit profanity with `/quit`.

> 🔐 Store your username + password in KeePassXC.

---

### 4. Run the installation script (optional)

To install the framework:

```bash
bash LainOS-Tor-XMPP-Server.sh
```

* **Important:** The script will prompt for the **PGP key password first**.
  **Do not include special characters** in that PGP password — the terminal can interpret them as shell syntax (which will break the prompt). Use only uppercase, lowercase, and numbers to be safe.
* Use KeePassXC to paste any required credentials into prompts.

---

### 5. Reconnect with your account

Exit profanity, reconnect with:

```bash
torsocks profanity -a yourusername@glcuf4hcwbm3lt6grg7jfwwus7sqpuojozfsnbzzcsf7vbm2jcfqckid.onion
```

Enter your PGPpassword, accept the certificate if prompted.

---

### 6. Join the official LainOS chatroom

From within profanity:

```profanity
/join private-chat-c75bebbc-50f3-447d-811f-41f83de11811@conference.glcuf4hcwbm3lt6grg7jfwwus7sqpuojozfsnbzzcsf7vbm2jcfqckid.onion
```

---

## ✅ Tips & Best Practices

* **Store credentials in KeePassXC**, never plaintext.
* **Enable OMEMO or PGP** encryption where supported.
* Always run XMPP clients through `torsocks` (or configure a Tor SOCKS proxy).
* Avoid special characters in passwords asked by the installer/script or the terminal (PGP password is asked first by the installer).
* Keep LainOS, Tor, and clients updated. Harden your device and operational practices.

---

## 🛠 Troubleshooting

* **Tor not at 100% / connection issues:**

  ```bash
  sudo journalctl -u tor -f
  ```
* **`torsocks` missing:** install via package manager.
* **Profanity certificate prompts:** inspect fingerprint before accepting.
* **Registration/connect fails:** ensure Tor is running, `torsocks` is used, and `.onion` hostnames are exact.

---

## 🧪 Related Project

Main repo: 👉 [vesme‑avf GitLab Repo](https://gitlab.com/amnesia1337/vesme-avf)

---

Stay secure. Stay private. Stay weird.
*— amnesia1337*

---

