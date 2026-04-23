# NutriLang Studio

NutriLang Studio est un mini environnement de développement pour **NutriLang**, un langage spécialisé orienté **nutrition et santé**.

Le projet combine :

- **Flex** pour l'analyse lexicale
- **Bison** pour l'analyse syntaxique
- **C** pour l'exécution
- **Flask** pour le backend web
- **HTML / CSS / JavaScript** pour l'interface web

L'objectif est de permettre à un utilisateur d'écrire un programme NutriLang, de l'exécuter depuis une interface moderne, puis d'afficher un rapport nutritionnel et des suggestions de repas.

---

## Sommaire

- [Installation & Utilisation](#installation--utilisation)
- [Fonctionnalités](#fonctionnalités)
- [Structure du projet](#structure-du-projet)
- [Exemples NutriLang](#exemples-nutrilang)
- [Dépannage](#dépannage)
- [Notes importantes](#notes-importantes)
- [Auteur](#auteur)

---

## Installation & Utilisation

### 1. Cloner le projet

```bash
git clone <URL_DU_REPO>
cd NutriLang
```

### 2. Installer les dépendances système (Linux / WSL)

```bash
sudo apt update
sudo apt install flex bison gcc make python3 python3-venv python3-pip -y
```

### 3. Créer et activer un environnement virtuel

```bash
python3 -m venv venv
source venv/bin/activate
```

### 4. Installer les dépendances Python

```bash
pip install flask flask-cors
```

### 5. Compiler le langage NutriLang

```bash
chmod +x compile.sh
./compile.sh
```

Cela va générer l'exécutable `nutrilang`.

### 6. Lancer le serveur Flask

```bash
cd web-ide
python3 server.py
```

### 7. Accéder à l'interface

Ouvre ton navigateur :

```
http://localhost:5000
```

### Exécution rapide après un pull

```bash
cd NutriLang
git pull
source venv/bin/activate
./compile.sh
cd web-ide
python3 server.py
```

---

## Fonctionnalités

NutriLang permet de :

- ✅ déclarer des variables numériques
- ✅ déclarer des repas avec leurs calories
- ✅ calculer l'IMC
- ✅ vérifier si un repas est healthy
- ✅ afficher des conseils nutritionnels
- ✅ définir un objectif :
  - `perte_poids`
  - `prise_muscle`
  - `maintien`
- ✅ générer des suggestions de repas
- ✅ utiliser des conditions :
  - `Si`
  - `Alors`
  - `Sinon`
  - `Finsi`
- ✅ afficher un rapport nutritionnel

L'interface permet également :

- ✅ choisir un exemple de code
- ✅ modifier le code
- ✅ exécuter le programme
- ✅ visualiser les résultats
- ✅ afficher des cartes de repas avec images

---

## Structure du projet

```
NUTRILANG/
│
├── langage1.l
├── langage1.y
├── compile.sh
├── nutrilang
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
```

---

## Exemples NutriLang

### Exemple 1 : Calcul IMC

```
poids := 72
taille := 1.70

Calculer_IMC poids taille
afficher_nutrition
```

### Exemple 2 : Vérification repas

```
Repas petit_dejeuner := 460
Verifier_healthy petit_dejeuner
afficher_nutrition
```

### Exemple 3 : Condition

```
poids := 95
taille := 1.72

Calculer_IMC poids taille

Si IMC > 25 Alors
    Conseil "Réduisez les calories"
Sinon
    Conseil "Continuez vos habitudes"
Finsi
```

### Exemple 4 : Programme complet

```
poids := 86
taille := 1.76

Calculer_IMC poids taille
Objectif perte_poids

Repas diner := 600
Verifier_healthy diner

Suggestion_healthy perte_poids

afficher_nutrition
```

---

## Dépannage

**Flask non installé**

```bash
pip install flask flask-cors
```

**Erreur `flex not found`**

```bash
sudo apt install flex
```

**Erreur `bison not found`**

```bash
sudo apt install bison
```

**Erreur `gcc not found`**

```bash
sudo apt install build-essential
```

**Erreur permission sur `compile.sh`**

```bash
chmod +x compile.sh
```

**Le fichier `nutrilang` est introuvable**

```bash
./compile.sh
```

**Les images ne s'affichent pas**

Vérifier que les images sont bien présentes dans :

```
web-ide/static/images/
```

---

## Notes importantes

- Le projet est conçu pour fonctionner sous **Linux** ou **WSL** (Windows Subsystem for Linux).
- L'environnement virtuel Python (`venv`) doit être activé à chaque nouvelle session avant de lancer le serveur.
- L'exécutable `nutrilang` doit être recompilé après toute modification des fichiers `.l` ou `.y`.

---

## Auteur

Projet réalisé dans le cadre d'un cours de compilation .
