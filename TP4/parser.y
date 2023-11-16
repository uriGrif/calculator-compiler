%code top{
#include <stdio.h>
#include <math.h> 
#include "scanner.h"
#include "calculadora.h"
}

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

%define api.value.type union

%token <double> NUMERO
%token <simbolo_tabla *>  IDENTIFICADOR
%token SALIR VAR
%token MAS_IGUAL "+=" 
%token MENOS_IGUAL "-="
%token DIVIDIDO_IGUAL "/="
%token POR_IGUAL "*="

%type <double> expresion

%right '=' "+=" "-+" "*="
%left '+' '-'
%left '/' '*'
%left NEG
%right '^'


%define parse.error verbose


%%
todo	: sesion { if (yynerrs || yylexerrs) YYABORT;};
sesion: sesion linea | %empty;
linea: expresion '\n' {printf ("\t%.10g\n", $1); }|
       VAR IDENTIFICADOR '\n' {printf("Define ID como variable\n\n");} |
       VAR IDENTIFICADOR  '=' expresion '\n' {printf("Define ID como variable con valor inicial\n\n");} |
       SALIR |
       '\n' |
       error '\n' ;
expresion: expresion '+' expresion {$$ = $1 + $3;}|
           expresion '-' expresion {$$ = $1 - $3;} |
           expresion '*' expresion {$$ = $1 * $3;}|
           expresion '/' expresion {$$ = $1 / $3;}|
           expresion '^' expresion {$$ = pow ($1,$3);}|
           '-' expresion %prec NEG {$$ = -$2;}| 
           IDENTIFICADOR {if($1->tipo == VAR) $$ = $1->valor.nro; else yyerror("algo no se")}|
           NUMERO {$$ = $1;} |
           '(' expresion ')' { $$ = $2;} | 
           IDENTIFICADOR "+=" expresion {printf("asignacion con suma\n");} |
           IDENTIFICADOR "-=" expresion {printf("asignacion con resta\n");} |
           IDENTIFICADOR "*=" expresion {printf("asignacion con multiplicacion\n");} |
           IDENTIFICADOR "/=" expresion {printf("asignacion con division\n");} |
           IDENTIFICADOR '(' expresion ')' {$$ = $1->valor.func($3);} ;
%%

void yyerror(const char *s){
	printf("%s\n\n",s);
	return;
}