%{
#include "langage1.tab.h"
#include <string.h>
#include <stdlib.h>
%}

%%
"Si"                 { return SI; }
"Alors"              { return ALORS; }
"Sinon"              { return SINON; }
"Finsi"              { return FINSI; }
"Tantque"            { return TANTQUE; }
"Fait"               { return FAIT; }
"Repas"              { return REPAS; }
"Calculer_IMC"       { return CALCULER_IMC; }
"Verifier_healthy"   { return VERIFIER_HEALTHY; }
"Conseil"            { return CONSEIL; }
"afficher_nutrition" { return AFFICHAGE; }
"Suggestion_healthy" { return SUGGESTION; }
"Objectif"           { return OBJECTIF; }

"perte_poids"        { return PERTE_POIDS; }
"prise_muscle"       { return PRISE_MUSCLE; }
"maintien"           { return MAINTIEN; }

"ET"                 { return ET; }
"OU"                 { return OU; }
"NON"                { return NON; }
":="                 { return ASSIGN; }
"=="                 { return EQ; }
">="                 { return GE; }
"<="                 { return LE; }
">"                  { return '>'; }
"<"                  { return '<'; }

[0-9]+(\.[0-9]+)?    { yylval.reel = atof(yytext); return NB; }
[a-zA-Z][a-zA-Z0-9_]* { yylval.nom = strdup(yytext); return ID; }

\"([^\"\\]|\\.)*\"   {
    yylval.nom = strdup(yytext + 1);
    yylval.nom[strlen(yylval.nom)-1] = '\0';
    return STRING;
}

"//".*               { ; }
[ \t\r\f]+           { ; }
"\n"                 { return '\n'; }
"+"                  { return '+'; }
"-"                  { return '-'; }
"*"                  { return '*'; }
"/"                  { return '/'; }
"("                  { return '('; }
")"                  { return ')'; }
.                    { printf("Erreur lexicale : [%s]\n", yytext); }
%%
int yywrap() { return 1; }