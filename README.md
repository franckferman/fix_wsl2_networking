<div id="top" align="center">

<!-- Shields Header -->
[![Contributors][contributors-shield]](https://github.com/franckferman/fix_wsl2_networking/graphs/contributors)
[![Stargazers][stars-shield]](https://github.com/franckferman/fix_wsl2_networking/stargazers)
[![License][license-shield]](https://github.com/franckferman/fix_wsl2_networking/blob/stable/LICENSE)

<!-- Logo -->
<a href="https://github.com/franckferman/fix_wsl2_networking">
  <img src="https://raw.githubusercontent.com/franckferman/fix_wsl2_networking/stable/docs/github/graphical_resources/banner-fix_wsl2_networking.jpg" alt="banner-fix_wsl2_networking" width="auto" height="auto">
</a>

<!-- Title & Tagline -->
<h3 align="center">fix_wsl2_networking</h3>
<p align="center">
    <em>Solve connection problems related to WSL2.</em>
    <br>
</p>

</div>

## 📜 Table of Contents

<details open>
  <summary><strong>Click to collapse/expand</strong></summary>
  <ol>
    <li><a href="#-about">📖 About</a></li>
    <li><a href="#-getting-started">🎮 Getting Started</a></li>
    <li><a href="#-license">📜 License</a></li>
    <li><a href="#-contact">📞 Contact</a></li>
  </ol>
</details>

## 📖 About

This script provides a permanent fix for a persistent issue affecting WSL2 users on various Linux distributions, including Debian, Ubuntu, and Kali.

Many users attempt temporary configuration tweaks, only to find the problem recurring. This script eliminates the hassle by offering a reliable, long-term solution that works seamlessly.

If you've been struggling with this issue, or know someone who is, this script is the definitive fix you've been looking for.

### Tested On

This script has been successfully tested on multiple WSL2 environments, including:

* - [x] [Debian](https://www.microsoft.com/en-us/p/debian/9msvkqc78pk6)
* - [x] [Ubuntu](https://www.microsoft.com/en-us/p/ubuntu/9pdxgncfsczv)
* - [x] [Kali Linux](https://www.microsoft.com/en-us/p/kali-linux/9pkr34tncv07)

<p align="right">(<a href="#top">back to top</a>)</p>

## 🎮 Getting Started

This repository is dedicated to fixing Internet connectivity issues in WSL2 when using a Linux distribution.

📌 Note: This guide does not cover WSL2 installation or setup—only the networking fix.

My goal is to provide a reliable and efficient solution to help WSL2 users restore network connectivity and optimize their workflow.

### Prerequisites

Download the script directly via PowerShell:

```PowerShell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/franckferman/fix_wsl2_networking/stable/fix_wsl2_networking.sh" -OutFile "C:\Users\$env:UserName\fix_wsl2_networking.sh"
```

## Usage

1️⃣ Move & execute the script from your Linux terminal in WSL2:

```sh
cd ~&&mv /mnt/c/Users/Your_Windows_UserName/fix_wsl2_networking.sh .&&chmod +x ./fix_wsl2_networking.sh&&sudo ./fix_wsl2_networking.sh
```

2️⃣ Once the script completes, your connectivity issues should be resolved.

<p align="right">(<a href="#top">back to top</a>)</p>

## 📜 License

This project is licensed under the GNU Affero General Public License, Version 3.0. For more details, please refer to the LICENSE file in the repository: [Read the license on GitHub](https://github.com/franckferman/fix_wsl2_networking/blob/stable/LICENSE)

<p align="right">(<a href="#top">back to top</a>)</p>

## 📞 Contact

[![ProtonMail][protonmail-shield]](mailto:contact@franckferman.fr)  [![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/franckferman)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/franckferman/fix_wsl2_networking.svg?style=for-the-badge
[contributors-url]: https://github.com/franckferman/fix_wsl2_networking/graphs/contributors
[stars-shield]: https://img.shields.io/github/stars/franckferman/fix_wsl2_networking.svg?style=for-the-badge
[stars-url]: https://github.com/franckferman/fix_wsl2_networking/stargazers
[license-shield]: https://img.shields.io/github/license/franckferman/fix_wsl2_networking.svg?style=for-the-badge
[license-url]: https://github.com/franckferman/fix_wsl2_networking/blob/stable/LICENSE
[protonmail-shield]: https://img.shields.io/badge/ProtonMail-8B89CC?style=for-the-badge&logo=protonmail&logoColor=blueviolet
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=blue
