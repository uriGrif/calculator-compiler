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
%token MAS_IGUAL "+=" 
%token MENOS_IGUAL "-="
%token DIVIDIDO_IGUAL "/="
%token POR_IGUAL "*="
%right '=' "+=" "-+" "*="
%left '+' '-'
%left '/' '*'
%left NEG
%right '^'

%define api.value.type {struct YYSTYPE}
%define parse.error verbose


%%
sesion: sesion linea | %empty {if (yynerrs || yylexerrs) YYABORT;};
linea: expresion '\n' {printf("Expresion\n");}|
       VAR IDENTIFICADOR linea_aux |
       SALIR |
       error '\n';
linea_aux: '\n' {printf("Define ID como variable\n");} |  
            '=' expresion '\n' {printf("Define ID como variable con valor inicial\n");} ;
expresion: expresion '+' expresion {printf("Suma\n");}|
           expresion '-' expresion {printf("Resta\n");} |
           expresion '*' expresion {printf("Multiplicacion\n");}|
           expresion '/' expresion {printf("Division\n");}|
           expresion '^' expresion {printf("Potenciacion\n");}|
           '-' expresion %prec NEG {printf("Cambio signo\n");}| 
           IDENTIFICADOR asignacion|
           NUMERO {printf("Numero\n");} |
           '(' expresion ')' {printf("cierra parentesis\n");};
asignacion: '=' expresion {printf("asignacion\n");} |
           "+=" expresion {printf("asignacion con suma\n");} |
           "-=" expresion {printf("asignacion con resta\n");} |
           "*=" expresion {printf("asignacion con multiplicacion\n");} |
           "/=" expresion {printf("asignacion con division\n");} |
           '(' expresion ')' {printf("funcion\n");} |
           %empty {printf("ID\n");};
%%

void yyerror(const char *s){
	puts(s);
	return;
}