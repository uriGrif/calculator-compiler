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


%token FDT IDENTIFICADOR NUMERO PALABRA_RESERVADA_SALIR PALABRA_RESERVADA_VAR
%token NUEVA_LINEA
%token MAS_IGUAL "+=" 
%token MENOS_IGUAL "-="
%token DIVIDIDO_IGUAL "/="
%token POR_IGUAL "*="
%right '=' "+=" "-+" "*="
%left '+' '-'
%left '/' '*'
%precedence NEG
%right '^'
%precedence '('  // ????????

%define api.value.type {struct YYSTYPE}
%define parse.error verbose

//hay que hacerle el alias al VAR Y SALIR

%%
sesion: sesion linea | %empty;
linea: expresion '\n'|
       VAR IDENTIFICADOR '\n'|
       VAR IDENTIFICADOR '=' expresion '\n' |
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
