<div id="top" align="center">

[![CI](https://github.com/franckferman/fix_wsl2_networking/actions/workflows/ci.yml/badge.svg)](https://github.com/franckferman/fix_wsl2_networking/actions/workflows/ci.yml)
[![Contributors][contributors-shield]](https://github.com/franckferman/fix_wsl2_networking/graphs/contributors)
[![Stargazers][stars-shield]](https://github.com/franckferman/fix_wsl2_networking/stargazers)
[![License][license-shield]](https://github.com/franckferman/fix_wsl2_networking/blob/stable/LICENSE)

<a href="https://github.com/franckferman/fix_wsl2_networking">
  <img src="https://raw.githubusercontent.com/franckferman/fix_wsl2_networking/stable/docs/banner-fix_wsl2_networking.jpg" alt="fix_wsl2_networking" width="100%">
</a>

<h3 align="center">fix_wsl2_networking</h3>
<p align="center">
  <em>Permanently fix DNS connectivity issues in WSL2.</em>
</p>

</div>

## Table of Contents

<details open>
  <summary><strong>Click to collapse/expand</strong></summary>
  <ol>
    <li><a href="#about">About</a></li>
    <li><a href="#how-it-works">How it works</a></li>
    <li><a href="#getting-started">Getting Started</a></li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

## About

WSL2 regenerates `/etc/resolv.conf` on each restart, overwriting any manual DNS configuration. This causes recurring connectivity failures, particularly in corporate or VPN environments where the automatically injected nameservers are unreachable or incorrect.

`fix_wsl2_networking` sets static DNS nameservers of your choice and makes the configuration files immutable, preventing WSL2 from reverting them on restart.

### Tested on

- [x] [Debian](https://www.microsoft.com/en-us/p/debian/9msvkqc78pk6)
- [x] [Ubuntu](https://www.microsoft.com/en-us/p/ubuntu/9pdxgncfsczv)
- [x] [Kali Linux](https://www.microsoft.com/en-us/p/kali-linux/9pkr34tncv07)

<p align="right">(<a href="#top">back to top</a>)</p>

## How it works

The script makes two changes:

**1. `/etc/wsl.conf`**

Sets `generateResolvConf=false` under the `[network]` section to tell WSL2 not to regenerate `/etc/resolv.conf` on startup.

**2. `/etc/resolv.conf`**

Replaces the file with a static configuration pointing to the DNS nameservers of your choice.

Both files are then marked immutable with `chattr +i`, which prevents WSL2 from modifying or replacing them even if `generateResolvConf` is ignored. Any existing files are backed up with a timestamp before modification.

To revert, run the script with `--undo`: this removes the immutable flags and deletes both files, allowing WSL2 to regenerate them on next restart.

<p align="right">(<a href="#top">back to top</a>)</p>

## Getting Started

### Download

Download the latest release from PowerShell:

```powershell
Invoke-WebRequest `
  -Uri "https://github.com/franckferman/fix_wsl2_networking/releases/latest/download/fix_wsl2_networking.sh" `
  -OutFile "$env:USERPROFILE\fix_wsl2_networking.sh"
```

Then from WSL2, copy from the Windows filesystem and run:

```sh
cp /mnt/c/Users/<YourWindowsUsername>/fix_wsl2_networking.sh ~/
chmod +x ~/fix_wsl2_networking.sh
sudo ~/fix_wsl2_networking.sh
```

<p align="right">(<a href="#top">back to top</a>)</p>

## Usage

```sh
sudo ./fix_wsl2_networking.sh [OPTIONS]
```

### Options

| Option | Description |
|---|---|
| `--dns <provider>` | Use a specific DNS provider (non-interactive) |
| `-y`, `--yes` | Skip confirmation prompt |
| `--undo` | Remove immutable flags and delete config files |
| `--dry-run` | Preview changes without modifying anything |
| `-h`, `--help` | Show help message |
| `--version` | Show version number |

### DNS providers

| Provider | Primary | Secondary |
|---|---|---|
| Cloudflare | 1.1.1.1 | 1.0.0.1 |
| Comodo | 8.26.56.26 | 8.20.247.20 |
| Digitalcourage | 85.214.20.141 | 46.182.19.48 |
| DNSWatch | 84.200.69.80 | 84.200.70.40 |
| FDN | 80.67.169.12 | 80.67.169.40 |
| Google | 8.8.8.8 | 8.8.4.4 |
| Mullvad | 194.242.2.9 | 194.242.2.2 |
| OpenDNS | 208.67.222.222 | 208.67.220.220 |
| Quad9 | 9.9.9.9 | 149.112.112.112 |

### Examples

Interactive mode (select DNS provider from a menu):

```sh
sudo ./fix_wsl2_networking.sh
```

Non-interactive mode with a specific provider:

```sh
sudo ./fix_wsl2_networking.sh --dns Cloudflare --yes
```

Preview changes without applying them:

```sh
sudo ./fix_wsl2_networking.sh --dry-run
```

Revert to automatic DNS configuration:

```sh
sudo ./fix_wsl2_networking.sh --undo
```

Once the script completes, restart WSL2 for the changes to take full effect:

```powershell
wsl --shutdown
```

<p align="right">(<a href="#top">back to top</a>)</p>

## License

Licensed under the GNU Affero General Public License v3.0. See [`LICENSE`](https://github.com/franckferman/fix_wsl2_networking/blob/stable/LICENSE) for details.

<p align="right">(<a href="#top">back to top</a>)</p>

## Contact

[![ProtonMail][protonmail-shield]](mailto:contact@franckferman.fr) [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/franckferman)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
[contributors-shield]: https://img.shields.io/github/contributors/franckferman/fix_wsl2_networking.svg?style=for-the-badge
[stars-shield]: https://img.shields.io/github/stars/franckferman/fix_wsl2_networking.svg?style=for-the-badge
[license-shield]: https://img.shields.io/github/license/franckferman/fix_wsl2_networking.svg?style=for-the-badge
[protonmail-shield]: https://img.shields.io/badge/ProtonMail-8B89CC?style=for-the-badge&logo=protonmail&logoColor=white
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=blue
