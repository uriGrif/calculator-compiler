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


%token FDT IDENTIFICADOR NUMERO SALIR VAR
%token NUEVA_LINEA '\n'
%token MAS_IGUAL "+=" 
%token MENOS_IGUAL "-="
%token DIVIDIDO_IGUAL "/="
%token POR_IGUAL "*="
%right '=' "+=" "-+" "*="
%left '+' '-'
%left '/' '*'
%precedence NEG
%right '^'

%define api.value.type {struct YYSTYPE}
%define parse.error verbose

//hay que hacerle el alias al VAR Y SALIR

%%
sesion: sesion linea | %empty;
linea: expresion '\n'|
       VAR IDENTIFICADOR linea_aux |
       SALIR;
linea_aux: '\n'| '=' expresion '\n';
expresion: expresion '+' expresion |
           expresion '-' expresion |
           expresion '*' expresion |
           expresion '/' expresion |
           expresion '^' expresion |
           '-' expresion %prec NEG | 
           IDENTIFICADOR asignacion|
           NUMERO |
           '(' expresion ')';
asignacion: '=' expresion |
           "+=" expresion |
           "-=" expresion |
            "*=" expresion |
           "/=" expresion |
           '(' expresion ')' | // hacer semantica funcion
           %empty;
