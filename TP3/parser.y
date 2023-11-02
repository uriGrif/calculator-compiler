%code top{
#include <stdio.h>
#include "scanner.h"
%}

%code provides{
void yyerror(const char *);
extern int yylexerrs;
}

%defines "parser.h"
%output "parser.c"


%token FDT IDENTIFICADOR NUMERO PALABRA_RESERVADA_SALIR PALABRA_RESERVADA_VAR MAS_IGUAL MENOS_IGUAL POR_IGUAL 
%token DIVIDIDO_IGUAL NUEVA_LINEA

