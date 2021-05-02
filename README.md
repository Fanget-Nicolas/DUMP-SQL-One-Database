<!-- PROJECT SHIELDS -->
<!--
*** I'm using markdown "reference style" links for readability.
*** Reference links are enclosed in brackets [ ] instead of parentheses ( ).
*** See the bottom of this document for the declaration of the reference variables
*** for contributors-url, forks-url, etc. This is an optional, concise syntax you may use.
*** https://www.markdownguide.org/basic-syntax/#reference-style-links
-->

<!--
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]
-->



<!-- PROJECT LOGO -->
<br />
<p align="center">
  <a href="https://github.com/Fanget-Nicolas/">
    <img src=".readme/images/logo.png" alt="Logo" width="80" height="80">
  </a>

  <h3 align="center">Dump SQP - One DataBase</h3>

  <p align="center">
    Script backup
    <br />
    <br />
    <a href="https://github.com/Fanget-Nicolas/DUMP-SQL-One-Database/issues">Signaler un bug</a>
    •
    <a href="https://github.com/Fanget-Nicolas/DUMP-SQL-One-Database/issues">Demander une fonctionnalité</a>
  </p>
</p>

<!-- ABOUT THE PROJECT -->
## :mag: À propos

<!--[![Product Name Screen Shot][product-screenshot]](https://example.com)-->

Ce script shell permet de faire un backup d'une seule base de donnée avec une rétention des backups sur plusieurs jours.

### :building_construction: Construit avec

* [Visual Studio Code](https://code.visualstudio.com/)


<!-- GETTING STARTED -->
## :rocket: Pour démarrer

Pour mettre en place une copie locale et la faire fonctionner, suivez les étapes simples ci-dessous.

### :card_file_box: Prérequis

Le système d'exploitation requis :
* OS : Linux
* gzip
* MySQL / MariaDB

### :package: Installation

1. Télécharger le script du dépôt.
2. Copier le script sur votre système d'exploitation Linux :
   ```sh
   mkdir /opt/backup/db/
   ```
3. Rendre le script exécutable :
   ```sh
   chmod +x ./dump-sql-one-db.sh
   ```
4. Configurer les variables du script :
   ```sh
   nano dump-sql-one-db.sh
   ```

<!-- USAGE EXAMPLES -->
## :tada: Utilisation

Exécution du script :
   ```sh
   ./dump-sql-one-db.sh
   ```

_Il existe plusieurs possibilités d'exécuter le script._

<!-- ROADMAP -->
## :construction: Roadmap

Consultez la rubrique [problèmes](https://github.com/Fanget-Nicolas/DUMP-SQL-One-Database/issues) pour obtenir une liste des fonctionnalités proposées (et des problèmes connus).

- [x] {1}
- [ ] {2}
- [ ] {3}


<!-- CONTRIBUTING -->
## :beers: Contribution

Les contributions sont ce qui fait de la communauté open source un endroit extraordinaire pour apprendre, inspirer et créer. Toutes les contributions que vous faites sont **grandement appréciées**.

1. Forké le projet
2. Créer votre branche Feature (`git checkout -b feature/AmazingFeature`)
3. Validez vos changements (`git commit -m 'Add some AmazingFeature'`)
4. Poussez vers la branche (`git push origin feature/AmazingFeature`)
5. Ouvrez une Pull Request



<!-- Licence -->
## :page_facing_up: Licence

Distribué sous la licence MIT. Voir le fichier `LICENSE` pour plus d'informations.



<!-- CONTACT -->
## :speech_balloon: Contact

<!-- Your Name - [@your_twitter](https://twitter.com/your_username) - email@example.com -->
Github : [https://github.com/Fanget-Nicolas](https://github.com/Fanget-Nicolas)


<!-- ACKNOWLEDGEMENTS -->
## :sparkles: Remerciements
* [GitHub Emoji Cheat Sheet](https://www.webpagefx.com/tools/emoji-cheat-sheet)
* [Img Shields](https://shields.io)
* [Choose an Open Source License](https://choosealicense.com)


<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/othneildrew/Best-README-Template.svg?style=for-the-badge
[contributors-url]: https://github.com/othneildrew/Best-README-Template/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/othneildrew/Best-README-Template.svg?style=for-the-badge
[forks-url]: https://github.com/othneildrew/Best-README-Template/network/members
[stars-shield]: https://img.shields.io/github/stars/othneildrew/Best-README-Template.svg?style=for-the-badge
[stars-url]: https://github.com/othneildrew/Best-README-Template/stargazers
[issues-shield]: https://img.shields.io/github/issues/othneildrew/Best-README-Template.svg?style=for-the-badge
[issues-url]: https://github.com/othneildrew/Best-README-Template/issues
[license-shield]: https://img.shields.io/github/license/othneildrew/Best-README-Template.svg?style=for-the-badge
[license-url]: https://github.com/othneildrew/Best-README-Template/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/othneildrew
[product-screenshot]: .readme/images/screenshot.png
