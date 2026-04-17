%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

struct symbole { char *nom; double valeur; } table[200];
int nb_symboles = 0;

#define STACK_MAX 64
int cond_stack[STACK_MAX];
int exec_stack[STACK_MAX];
int stack_top = 0;

int should_exec() {
    if (stack_top == 0) return 1;
    return exec_stack[stack_top - 1];
}

double getValeur(char *nom) {
    for (int i = 0; i < nb_symboles; i++)
        if (strcmp(table[i].nom, nom) == 0) return table[i].valeur;
    return 0.0;
}

void setValeur(char *nom, double val) {
    if (!should_exec()) return;
    for (int i = 0; i < nb_symboles; i++) {
        if (strcmp(table[i].nom, nom) == 0) {
            table[i].valeur = val;
            return;
        }
    }
    table[nb_symboles].nom = strdup(nom);
    table[nb_symboles].valeur = val;
    nb_symboles++;
}

void afficherNutrition() {
    if (!should_exec()) return;
    printf("\n=== RAPPORT NUTRITIONNEL NUTRILANG ===\n");
    int max_len = 0;
    for (int i = 0; i < nb_symboles; i++) {
        int l = (int)strlen(table[i].nom);
        if (l > max_len) max_len = l;
    }
    for (int i = 0; i < nb_symboles; i++)
        printf("-> %*s = %.2f\n", max_len, table[i].nom, table[i].valeur);
    printf("====================================\n");
}

void suggestion_healthy(char *type) {
    if (!should_exec()) return;
    printf("\n🍽️  Suggestions de repas healthy (%s) :\n", type);
    
    if (strcmp(type, "perte_poids") == 0) {
        printf("1. Salade de poulet grillé aux légumes frais (420 kcal)\n");
        printf("   Image : salade colorée avec poulet grillé, tomates cerises, concombre, avocat et vinaigrette légère\n\n");
        
        printf("2. Yaourt grec nature avec baies et amandes (380 kcal)\n");
        printf("   Image : bol de yaourt grec garni de fraises, myrtilles, framboises et amandes effilées\n\n");
        
        printf("3. Poisson blanc vapeur avec brocoli et quinoa (450 kcal)\n");
        printf("   Image : filet de cabillaud vapeur accompagné de brocoli vif et quinoa doré\n");
        
    } else if (strcmp(type, "prise_muscle") == 0) {
        printf("1. Omelette aux 4 œufs avec avocat et pain complet (680 kcal)\n");
        printf("   Image : omelette dorée aux herbes avec tranches d'avocat et pain grillé\n\n");
        
        printf("2. Poulet rôti avec riz complet et légumes (750 kcal)\n");
        printf("   Image : poitrine de poulet rôti juteuse avec riz complet et mélange de légumes colorés\n\n");
        
        printf("3. Shake protéiné banane et beurre de cacahuète (580 kcal)\n");
        printf("   Image : grand verre de shake crémeux à la banane avec une cuillère de beurre de cacahuète\n");
        
    } else { // maintien
        printf("1. Bowl quinoa saumon avocat (590 kcal)\n");
        printf("   Image : bol de quinoa avec saumon grillé, avocat en tranches et graines de sésame\n\n");
        
        printf("2. Salade complète thon œuf et légumes (520 kcal)\n");
        printf("   Image : salade généreuse avec thon, œuf dur, tomates, concombre et olives\n\n");
        
        printf("3. Lentilles corail aux épinards et carottes (480 kcal)\n");
        printf("   Image : plat de lentilles corail orange avec épinards frais et carottes râpées\n");
    }
}

int yylex();
void yyerror(const char *s);
%}

%union { double reel; char *nom; }

%token <reel> NB
%token <nom> ID STRING
%token SI ALORS SINON FINSI TANTQUE FAIT
%token REPAS CALCULER_IMC VERIFIER_HEALTHY CONSEIL AFFICHAGE SUGGESTION OBJECTIF
%token PERTE_POIDS PRISE_MUSCLE MAINTIEN
%token ET OU NON ASSIGN EQ GE LE

%type <reel> exp cond

%left OU ET
%right NON
%left '+' '-'
%left '*' '/'
%nonassoc GE LE EQ '>' '<'

%%
programme
    : /* vide */
    | programme sep
    | programme instruction sep
    ;

sep : '\n' | sep '\n' ;

instruction
    : ID ASSIGN exp {
          if (should_exec()) {
              setValeur($1, $3);
              printf(">> %s := %.2f\n", $1, $3);
          }
      }
    | REPAS ID ASSIGN exp {
          if (should_exec()) {
              setValeur($2, $4);
              printf(">> Repas %s declare (%.0f kcal)\n", $2, $4);
          }
      }
    | CALCULER_IMC exp exp {
          if (should_exec()) {
              double imc = ($3 != 0) ? $2 / ($3 * $3) : 0;
              setValeur("IMC", imc);
              printf(">> IMC calcule : %.2f\n", imc);
          }
      }
    | VERIFIER_HEALTHY ID {
          if (should_exec()) {
              double cal = getValeur($2);
              if (cal > 0 && cal <= 700)
                  printf(">> %s est HEALTHY\n", $2);
              else
                  printf(">> %s est TROP CALORIQUE\n", $2);
          }
      }
    | CONSEIL STRING {
          if (should_exec())
              printf("Conseil nutrition : %s\n", $2);
      }
    | AFFICHAGE {
          if (should_exec()) afficherNutrition();
      }
    | OBJECTIF PERTE_POIDS {
          if (should_exec()) printf(">> Objectif défini : Perte de poids\n");
      }
    | OBJECTIF PRISE_MUSCLE {
          if (should_exec()) printf(">> Objectif défini : Prise de muscle\n");
      }
    | OBJECTIF MAINTIEN {
          if (should_exec()) printf(">> Objectif défini : Maintien\n");
      }
    | SUGGESTION PERTE_POIDS {
          suggestion_healthy("perte_poids");
      }
    | SUGGESTION PRISE_MUSCLE {
          suggestion_healthy("prise_muscle");
      }
    | SUGGESTION MAINTIEN {
          suggestion_healthy("maintien");
      }
    | structure_si
    ;

structure_si
    : SI cond ALORS {
          int parent = should_exec();
          int cv = ($2 != 0.0);
          cond_stack[stack_top] = cv;
          exec_stack[stack_top] = parent && cv;
          stack_top++;
      }
      bloc
      bloc_sinon
      FINSI {
          stack_top--;
      }
    ;

bloc
    : /* vide */
    | bloc sep
    | bloc instruction sep
    ;

bloc_sinon
    : /* vide */
    | SINON {
          int parent = (stack_top >= 2) ? exec_stack[stack_top - 2] : 1;
          exec_stack[stack_top - 1] = parent && !cond_stack[stack_top - 1];
      }
      bloc
    ;

cond
    : exp EQ exp { $$ = ($1 == $3); }
    | exp '>' exp { $$ = ($1 > $3); }
    | exp '<' exp { $$ = ($1 < $3); }
    | exp GE exp { $$ = ($1 >= $3); }
    | exp LE exp { $$ = ($1 <= $3); }
    | cond ET cond { $$ = ($1 && $3); }
    | cond OU cond { $$ = ($1 || $3); }
    | NON cond { $$ = !$2; }
    ;

exp
    : NB { $$ = $1; }
    | ID { $$ = getValeur($1); }
    | exp '+' exp { $$ = $1 + $3; }
    | exp '-' exp { $$ = $1 - $3; }
    | exp '*' exp { $$ = $1 * $3; }
    | exp '/' exp { $$ = ($3 != 0) ? $1 / $3 : 0; }
    | '(' exp ')' { $$ = $2; }
    ;

%%
void yyerror(const char *s) {
    fprintf(stderr, "[Erreur] %s\n", s);
}

int main() {
    printf("NutriLang v1.0 - Langage Nutrition & Santé\n\n");
    return yyparse();
}