# NutriLang Studio

NutriLang Studio est un mini environnement de développement pour **NutriLang**, un langage spécialisé orienté **nutrition et santé**.

Le projet combine :

- **Flex** pour l’analyse lexicale
- **Bison** pour l’analyse syntaxique
- **C** pour l’exécution
- **Flask** pour le backend web
- **HTML / CSS / JavaScript** pour l’interface web

L’objectif est de permettre à un utilisateur d’écrire un programme NutriLang, de l’exécuter depuis une interface moderne, puis d’afficher un rapport nutritionnel et des suggestions de repas.

---

# Sommaire

- [1. Fonctionnalités](#1-fonctionnalités)
- [2. Structure du projet](#2-structure-du-projet)
- [3. Prérequis](#3-prérequis)
- [4. Cloner ou récupérer le projet](#4-cloner-ou-récupérer-le-projet)
- [5. Installation étape par étape](#5-installation-étape-par-étape)
- [6. Compilation du langage](#6-compilation-du-langage)
- [7. Lancement du serveur web](#7-lancement-du-serveur-web)
- [8. Accès à l’interface](#8-accès-à-linterface)
- [9. Exécution rapide après un pull](#9-exécution-rapide-après-un-pull)
- [10. Exemples NutriLang](#10-exemples-nutrilang)
- [11. Commandes utiles](#11-commandes-utiles)
- [12. Dépannage](#12-dépannage)
- [13. Notes importantes](#13-notes-importantes)

---

# 1. Fonctionnalités

NutriLang permet notamment de :

- déclarer des variables numériques
- déclarer des repas avec leurs calories
- calculer l’IMC
- vérifier si un repas est healthy
- afficher des conseils nutritionnels
- définir un objectif nutritionnel :
  - `perte_poids`
  - `prise_muscle`
  - `maintien`
- générer des suggestions de repas selon l’objectif
- utiliser une condition :
  - `Si`
  - `Alors`
  - `Sinon`
  - `Finsi`
- afficher un rapport nutritionnel

L’interface web permet également :

- de choisir un exemple de code par défaut
- d’écrire un programme dans un éditeur
- de lancer l’exécution
- de visualiser les résultats
- d’afficher des suggestions de repas avec images

---

# 2. Structure du projet

Organisation recommandée :

```text
NUTRILANG/
│
├── langage1.l
├── langage1.y
├── compile.sh
├── nutrilang                # généré après compilation
│
└── web-ide/
    ├── server.py
    ├── templates/
    │   └── index.html
    └── static/
        └── images/
            ├── salade-poulet.jpg
            ├── yaourt-grec.jpg
            ├── poisson-brocoli.jpg
            ├── omelette-avocat.jpg
            ├── poulet-riz.jpg
            ├── shake-banane.jpg
            ├── bowl-saumon.jpg
            ├── salade-thon.jpg
            ├── lentilles-corail.jpg
            └── default-meal.jpg

## Installation & Utilisation

### 1. Compilation du langage

python3 -m venv venv
source venv/bin/activate
pip install flask flask-cors
chmod +x compile.sh
./compile.sh
cd web..
python3 server.py
