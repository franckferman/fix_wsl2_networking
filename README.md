# fix_wsl2_networking
Fix connection issues related to WSL2.

<div id="top"></div>

[![Contributors][contributors-shield]](https://github.com/franckferman/fix_wsl2_networking/graphs/contributors)
[![Forks][forks-shield]](https://github.com/franckferman/fix_wsl2_networking/network/members)
[![Stargazers][stars-shield]](https://github.com/franckferman/fix_wsl2_networking/stargazers)
[![Issues][issues-shield]](https://github.com/franckferman/fix_wsl2_networking/issues)
[![MIT License][license-shield]](https://github.com/franckferman/fix_wsl2_networking/blob/main/LICENSE)
[![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/fferman42)

<br />
<div align="center">
  <a href="https://github.com/franckferman/fix_wsl2_networking">
    <img src="https://raw.githubusercontent.com/franckferman/fix_wsl2_networking/main/img/glass-science.png" alt="Logo" width="80" height="80">
  </a>

<h3 align="center">fix_wsl2_networking</h3>

  <p align="center">
    Fix connection issues related to WSL2.
    <br />
    <a href="https://github.com/franckferman/fix_wsl2_networking"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://github.com/franckferman/fix_wsl2_networking">View Demo</a>
    ·
    <a href="https://github.com/franckferman/fix_wsl2_networking/issues">Report Bug</a>
    ·
    <a href="https://github.com/franckferman/fix_wsl2_networking/issues">Request Feature</a>
  </p>
</div>

<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

<!-- ABOUT THE PROJECT -->
## About The Project

[![asciicast](https://asciinema.org/a/3Spj6xlfc2E4KgdS4htiJVUfM.svg)](https://asciinema.org/a/3Spj6xlfc2E4KgdS4htiJVUfM)

This repository was created in order to repair the connection problem related to WSL2 (as you can see above).

<p align="right">(<a href="#top">back to top</a>)</p>

### Built With

Here are the different tools that I used to create my script and performed my tests.

* [WSL2](https://github.com/microsoft/WSL2-Linux-Kernel)
* [Debian](https://www.microsoft.com/en-us/p/debian/9msvkqc78pk6)
* [Ubuntu](https://www.microsoft.com/en-us/p/ubuntu/9nblggh4msv6)
* [Vim](https://github.com/vim/vim)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

This repository is not intended to teach you how to install (and configure) WSL2 on your operating system. I assume that you already have your distribution ready and installed on your system and that you are precisely facing the connection problem.

### Prerequisites

To start, you need to download my script and change the permission of it to be able to run it on your Linux distribution. This part is reserved for beginners who are not used to using and downloading tools from Github. See even reserved for beginners in computer science in general. There are many solutions to download and then run my script on your distro but I'll show you mine.

* From PowerShell
  ```sh
  Start-BitsTransfer -Source https://raw.githubusercontent.com/franckferman/fix_wsl2_networking/main/fix_wsl2_networking.sh -Destination C:\
  ```
  
  This command will download my script to the root of your system (C:\).
  
  * Now, from your Linux distribution (on which you have your connection problems).
  ```sh
  cp /mnt/c/fix_wsl2_networking.sh .
  chmod a+x ./fix_wsl2_networking.sh
  ```
  
  The first command allows you to copy the script (previously downloaded with PowerShell on your main operating system) to the current directory on your Linux distribution.
  For more information on the cp command, its parameters, and how it works :
   ```sh
  man cp
  ```
  
  The second command simply allows you to change the permissions of the file that will allow you to run the script.
   For more information on the chmod command, its parameters, and how it works :
   ```sh
  man chmod
  ```

<!-- USAGE EXAMPLES -->
## Usage

To run the script, you just need to use the following command.
```sh
  ./fix_wsl2_networking.sh
  ```

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- CONTACT -->
## Contact

Franck FERMAN - [LinkedIn](https://www.linkedin.com/in/fferman42) - fferman@protonmail.ch

Project Link: [https://github.com/franckferman/fix_wsl2_networking](https://github.com/franckferman/fix_wsl2_networking)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- MARKDOWN LINKS & IMAGES -->
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
[linkedin-url]: https://linkedin.com/in/fferman42
[product-screenshot]: images/screenshot.png
