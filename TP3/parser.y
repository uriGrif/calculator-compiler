%code top{
#include <stdio.h>
#include "scanner.h"
%}

%code provides{
struct YYSTYPE{
    double real;
    char*  str;
};
void yyerror(const char *);
extern int yylexerrs;
}



%defines "parser.h"
%output "parser.c"


%token FDT IDENTIFICADOR NUMERO PALABRA_RESERVADA_SALIR PALABRA_RESERVADA_VAR MAS_IGUAL MENOS_IGUAL POR_IGUAL 
%token DIVIDIDO_IGUAL NUEVA_LINEA
%define api.value.type {struct YYSTYPE}

//hay que hacerle el alias al VAR Y SALIR

%%
sesion: sesion linea | %empty;
linea: expresion |
       VAR IDENTIFICADOR |
       VAR IDENTIFICADOR '=' expresion |
       SALIR; 
expresion: expresion '+' expresion |
           expresion '-' expresion |
           expresion '*' expresion |
           expresion '/' expresion |
           expresion '^' expresion |
           '-' expresion %prec NEG | 
           IDENTIFICADOR '=' expresion |
           IDENTIFICADOR "+=" expresion |
           IDENTIFICADOR "-=" expresion |
           IDENTIFICADOR  "*=" expresion |
           IDENTIFICADOR "/=" expresion |
           IDENTIFICADOR |
           NUMERO |
           '(' expresion ')' |
           funcion '(' expresion ')';
funcion ???? 
