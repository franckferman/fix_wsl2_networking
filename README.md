<div id="top"></div>

[![Contributors][contributors-shield]](https://github.com/franckferman/fix_wsl2_networking/graphs/contributors)
[![Forks][forks-shield]](https://github.com/franckferman/fix_wsl2_networking/network/members)
[![Stargazers][stars-shield]](https://github.com/franckferman/fix_wsl2_networking/stargazers)
[![Issues][issues-shield]](https://github.com/franckferman/fix_wsl2_networking/issues)
[![MIT License][license-shield]](https://github.com/franckferman/fix_wsl2_networking/blob/main/LICENSE)
[![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/franckferman)

<br/>
<div align="center">
  <a href="https://github.com/franckferman/fix_wsl2_networking">
    <img src="https://raw.githubusercontent.com/franckferman/fix_wsl2_networking/main/graphical_resources/banner-fix_wsl2_networking.jpg" alt="banner-fix_wsl2_networking">
  </a>
  
<h3 align="center">fix_wsl2_networking</h3>

  <p align="center">
    Solve connection problems related to WSL2.
    <br/><br/>
    <a href="https://github.com/franckferman/fix_wsl2_networking/issues">Report Bug</a>
    ·
    <a href="https://github.com/franckferman/fix_wsl2_networking/issues">Request Feature</a>
  </p>
</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about">About</a>
      <ul>
        <li><a href="#tested-on">Tested on</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>

## About

This script was specifically created to address the recurring problem faced by countless WSL2 users on various operating systems, including Debian, Ubuntu, Kali Linux, and more.

While some have resorted to temporarily tweaking configuration files, the issue often persists, leaving frustrated users seeking a more sustainable fix. This is where my script comes in, providing a reliable and long-term solution that you can count on.

Whether you're experiencing this problem yourself or know someone who is, my script is probably the solution you've been looking for.

<p align="right">(<a href="#top">back to top</a>)</p>

### Tested On

The script has been tested on multiple systems with WSL2:

* - [x] [Debian](https://www.microsoft.com/en-us/p/debian/9msvkqc78pk6)
* - [x] [Ubuntu](https://www.microsoft.com/en-us/p/ubuntu/9pdxgncfsczv)
* - [x] [Kali Linux](https://www.microsoft.com/en-us/p/kali-linux/9pkr34tncv07)

<p align="right">(<a href="#top">back to top</a>)</p>

## Getting Started

Please note that this repository is solely focused on resolving Internet connectivity issues faced by users when using WSL2 with a Linux distribution. As such, I will not be providing guidance or instructions on how to set up WSL2 or install a specific operating system.

My primary objective is to provide a reliable and effective solution to address the connection issues encountered by WSL2 users, and I hope that my script can help you overcome these challenges and streamline your workflow.

### Prerequisites

To begin, you can download my script by running the following command in PowerShell:

```PowerShell
Invoke-WebRequest -Uri "https://raw.githubusercontent.com/franckferman/fix_wsl2_networking/main/fix_wsl2_networking.sh" -OutFile "C:\Users\$env:UserName\fix_wsl2_networking.sh"
```

## Usage

Once the script has been downloaded, you can proceed to the terminal of your Linux system to move then run the script and fix your connectivity issues.

```sh
cd ~&&mv /mnt/c/Users/Your_Windows_UserName/fix_wsl2_networking.sh&&chmod +x ./fix_wsl2_networking.sh&&sudo ./fix_wsl2_networking.sh
```

Once you have successfully completed these steps, your connectivity issues should be resolved.

<p align="right">(<a href="#top">back to top</a>)</p>

## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

<p align="right">(<a href="#top">back to top</a>)</p>

## License

Distributed under the MIT License. See `LICENSE` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>

## Contact

Franck FERMAN - [LinkedIn](https://www.linkedin.com/in/franckferman) - fferman@protonmail.ch

Project Link: [https://github.com/franckferman/fix_wsl2_networking](https://github.com/franckferman/fix_wsl2_networking)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/franckferman/fix_wsl2_networking.svg?style=for-the-badge
[contributors-url]: https://github.com/franckferman/fix_wsl2_networking/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/franckferman/fix_wsl2_networking.svg?style=for-the-badge
[forks-url]: https://github.com/franckferman/fix_wsl2_networking/network/members
[stars-shield]: https://img.shields.io/github/stars/franckferman/fix_wsl2_networking.svg?style=for-the-badge
[stars-url]: https://github.com/franckferman/fix_wsl2_networking/stargazers
[issues-shield]: https://img.shields.io/github/issues/franckferman/fix_wsl2_networking.svg?style=for-the-badge
[issues-url]: https://github.com/franckferman/fix_wsl2_networking/issues
[license-shield]: https://img.shields.io/github/license/franckferman/fix_wsl2_networking.svg?style=for-the-badge
[license-url]: https://github.com/franckferman/fix_wsl2_networking/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/franckferman
[product-screenshot]: images/screenshot.png
