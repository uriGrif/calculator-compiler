%code top{
#include <stdio.h>
#include "scanner.h"
}

%code provides{
void yyerror(const char *);
extern int yylexerrs;
}

%defines "parser.h"
%output "parser.c"


%token IDENTIFICADOR NUMERO SALIR VAR
%token MAS_IGUAL "+=" 
%token MENOS_IGUAL "-="
%token DIVIDIDO_IGUAL "/="
%token POR_IGUAL "*="
%right '=' "+=" "-+" "*="
%left '+' '-'
%left '/' '*'
%left NEG
%right '^'

%define parse.error verbose


%%
todo	: sesion { if (yynerrs || yylexerrs) YYABORT;};
sesion: sesion linea | %empty;
linea: expresion '\n' {printf("Expresion\n\n");}|
       VAR IDENTIFICADOR '\n' {printf("Define ID como variable\n\n");} |
       VAR IDENTIFICADOR  '=' expresion '\n' {printf("Define ID como variable con valor inicial\n\n");} |
       SALIR |
       '\n' |
       error '\n';
expresion: expresion '+' expresion {printf("Suma\n");}|
           expresion '-' expresion {printf("Resta\n");} |
           expresion '*' expresion {printf("Multiplicacion\n");}|
           expresion '/' expresion {printf("Division\n");}|
           expresion '^' expresion {printf("Potenciacion\n");}|
           '-' expresion %prec NEG {printf("Cambio signo\n");}| 
           IDENTIFICADOR {printf("ID\n");}|
           IDENTIFICADOR '=' expresion {printf("asignacion\n");} | 
           NUMERO {printf("Numero\n");} |
           '(' expresion ')' {printf("cierra parentesis\n");} | 
           IDENTIFICADOR "+=" expresion {printf("asignacion con suma\n");} |
           IDENTIFICADOR "-=" expresion {printf("asignacion con resta\n");} |
           IDENTIFICADOR "*=" expresion {printf("asignacion con multiplicacion\n");} |
           IDENTIFICADOR "/=" expresion {printf("asignacion con division\n");} |
           IDENTIFICADOR '(' expresion ')' {printf("funcion\n");} ;
%%

void yyerror(const char *s){
	printf("%s\n\n",s);
	return;
}