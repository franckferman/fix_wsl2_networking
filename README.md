<div id="top"></div>

[![Contributors][contributors-shield]](https://github.com/franckferman/fix_wsl2_networking/graphs/contributors)
[![Forks][forks-shield]](https://github.com/franckferman/fix_wsl2_networking/network/members)
[![Stargazers][stars-shield]](https://github.com/franckferman/fix_wsl2_networking/stargazers)
[![Issues][issues-shield]](https://github.com/franckferman/fix_wsl2_networking/issues)
[![MIT License][license-shield]](https://github.com/franckferman/fix_wsl2_networking/blob/main/LICENSE)
[![LinkedIn][linkedin-shield]](https://www.linkedin.com/in/franckferman)

<br />
<div align="center">
  <a href="https://github.com/franckferman/fix_wsl2_networking">
    <img src="https://raw.githubusercontent.com/franckferman/fix_wsl2_networking/main/img/logo.png" alt="Logo" width="80" height="80">
  </a>
  
  <a href="https://github.com/franckferman/fix_wsl2_networking">
    <img src="https://raw.githubusercontent.com/franckferman/fix_wsl2_networking/main/graphical_resources/banner-fix_wsl2_networking.jpg" alt="banner-fix_wsl2_networking" width="2000" height="6912">
  </a>
  
  graphical_resources

<h3 align="center">fix_wsl2_networking</h3>

  <p align="center">
    Solve connection problems related to WSL2.
    <br />
    <a href="https://github.com/franckferman/fix_wsl2_networking"><strong>Explore the docs »</strong></a>
    <br />
    <br />
    <a href="https://asciinema.org/a/6bFdhWtusnKPAiitaZDAAmnoq">View Demo</a>
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

<!-- ABOUT THE PROJECT -->
## About The Project

[![asciicast](https://asciinema.org/a/WkL7z4x5lBqCYPKZuGdbNPN3y.svg)](https://asciinema.org/a/WkL7z4x5lBqCYPKZuGdbNPN3y)

This script was created in order to solve connection problems related to WSL2.

This problem has been observed by many people, on many systems using WSL2 such as Debian, Ubuntu, Kali Linux...

This problem can easily be solved temporarily by changing some configuration files. The problem is that it usually doesn't last and the problem starts again...

Again, many people have reported this problem, including people I know who have asked me if I could provide a solution.

That's why, once again, I decided to create this repository.

<p align="right">(<a href="#top">back to top</a>)</p>

### Tested On

The script has been tested and the tests have been performed with WSL2 on these systems:
* - [x] [Debian](https://www.microsoft.com/en-us/p/debian/9msvkqc78pk6)
* - [x] [Ubuntu](https://www.microsoft.com/en-us/p/ubuntu/9pdxgncfsczv)
* - [x] [Kali Linux](https://www.microsoft.com/en-us/p/kali-linux/9pkr34tncv07)

<p align="right">(<a href="#top">back to top</a>)</p>

<!-- GETTING STARTED -->
## Getting Started

I won't show you how to set up WSL2 and install a system.

For the simple reason that this repository is not a course, it has, once again, simply for the sole purpose of helping you to solve the Internet connectivity problems that users encounter when using WSL2 with a Linux distribution.

### Prerequisites

To start, you will download my script and place it in the root of your Windows system.

* To do this, launch PowerShell with Administrator rights and run the following command:
```sh
Start-BitsTransfer -Source https://raw.githubusercontent.com/franckferman/fix_wsl2_networking/main/fix_wsl2_networking.sh -Destination "C:\" -DisplayName "fix_wsl2_networking - Downloading function - Franck FERMAN." -Description "Downloading the script."
```

<!-- USAGE EXAMPLES -->
## Usage

After downloading the script to the root of your Windows system as seen above, you will go to the terminal of your Linux system.
  
  * From your Linux terminal, on which you have connectivity problems, run the following commands:
```sh
cd ~;cp /mnt/c/fix_wsl2_networking.sh .;chmod a+x ./fix_wsl2_networking.sh;sudo ./fix_wsl2_networking.sh
```
  
I am not here to teach you how to use a Linux terminal but to summarize we have: change directory to go to the home directory of our Linux user, copy the script (which was in the root of Windows system) in the current directory of our Linux user (home), change the permissions of the file (script) to add execution rights, then run it with Administrator rights (sudo).

  * For more information on the commands used, remember that the man is your friend:
```sh
man cd
man cp
man chmod
```
  
After testing the connectivity of your Linux system, you can return to your PowerShell terminal to delete the script.
   ```sh
Remove-Item -Path "C:\fix_wsl2_networking.sh" -Force
  ```
  
Once this is done, everything should work.
  
  [![asciicast](https://asciinema.org/a/6bFdhWtusnKPAiitaZDAAmnoq.svg)](https://asciinema.org/a/6bFdhWtusnKPAiitaZDAAmnoq)

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

Franck FERMAN - [LinkedIn](https://www.linkedin.com/in/franckferman) - fferman@protonmail.ch

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
[linkedin-url]: https://linkedin.com/in/franckferman
[product-screenshot]: images/screenshot.png
