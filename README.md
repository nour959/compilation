# NutriLang Studio

**NutriLang** est un langage de programmation simple et éducatif dédié à la nutrition et à la santé.  
Il permet d’écrire des scripts pour calculer l’IMC, déclarer des repas, vérifier leur qualité, définir des objectifs et recevoir des suggestions personnalisées.

Projet réalisé dans le cadre d’un cours de compilation (Flex + Bison + Interface Web).

---

## Fonctionnalités

- Déclaration de variables (`poids`, `taille`, `age`…)
- Calcul de l’**IMC** avec interprétation automatique
- Déclaration de repas avec calories (`Repas nom := calories`)
- Vérification si un repas est **healthy** ou trop calorique
- Définition d’**objectif** : `perte_poids`, `prise_muscle`, `maintien`
- Suggestions de repas adaptés à l’objectif (`Suggestion_healthy`)
- Structures conditionnelles : `Si ... Alors ... Sinon ... Finsi`
- Conseils personnalisés (`Conseil "texte"`)
- Affichage du rapport nutritionnel (`afficher_nutrition`)
- Interface web moderne avec éditeur et sortie en temps réel

---

## Installation & Utilisation

### 1. Compilation du langage

```bash
cd /mnt/c/Users/Nour/Desktop/NutriLang

# Rendre le script exécutable (une seule fois)
chmod +x compile.sh

# Compiler
./compile.sh


2. Lancement de l’interface web
Bashcd web-ide
source venv/bin/activate     # Si vous utilisez l'environnement virtuel
python server.py



Commandes disponibles

Commande,Description
poids := 75,Assignation de variable
Calculer_IMC poids taille,Calcul et affichage de l’IMC
Repas nom := 650,Déclarer un repas
Verifier_healthy nom,Vérifier si le repas est healthy
Objectif perte_poids,Définir l’objectif
Suggestion_healthy ...,Afficher des suggestions adaptées
Si ... Alors ... Finsi,Structure conditionnelle
"Conseil ""texte""",Afficher un conseil
afficher_nutrition,Afficher le rapport complet


Structure du projet 

NutriLang/
├── langage1.l              # Analyseur lexical (Flex)
├── langage1.y              # Analyseur syntaxique et sémantique (Bison)
├── compile.sh              # Script de compilation
├── nutrilang               # Exécutable généré
├── web-ide/
│   ├── server.py           # Serveur Flask
│   └── templates/
│       └── index.html      # Interface web
└── README.md