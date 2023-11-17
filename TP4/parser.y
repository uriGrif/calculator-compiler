%code top{
#include <stdio.h>
#include <math.h> 
#include "scanner.h"
#include "calculadora.h"
}

%union{
    double val;
    struct simbolo_tabla * reg;
}

%code provides{
void yyerror(const char *);
extern int yylexerrs;
}

%defines "parser.h"
%output "parser.c"



%token  <val> NUMERO
%token <reg> IDENTIFICADOR FUN
%type <val> expresion
%token SALIR VAR
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
todo	: sesion { if (yynerrs || yylexerrs || nsemnterrs) YYABORT;};
sesion: sesion linea | %empty;
linea: expresion '\n' {printf ("%f\n", $1); }|
       VAR IDENTIFICADOR '\n' {printf("%s: %f\n",$2->lexema,$2->valor.nro);} |
       VAR IDENTIFICADOR  '=' expresion '\n' {$2->valor.nro = $4; printf("%s: %f\n",$2->lexema,$2->valor.nro);} |
       SALIR |
       '\n' |
       error '\n' ;
expresion: expresion '+' expresion {$$ = $1 + $3;}|
           expresion '-' expresion {$$ = $1 - $3;} |
           expresion '*' expresion {$$ = $1 * $3;}|
           expresion '/' expresion {$$ = $1 / $3;}|
           expresion '^' expresion {$$ = pow ($1,$3);}|
           '-' expresion %prec NEG {$$ = -$2;}| 
           IDENTIFICADOR {if($1->tipo == VARIABLE) $$ = $1->valor.nro; else yyerror("algo no se");}|
           IDENTIFICADOR '=' expresion {printf("asignacion\n");} | 
           NUMERO {$$ = $1;} |
           '(' expresion ')' { $$ = $2;} | 
           IDENTIFICADOR "+=" expresion {printf("asignacion con suma\n");} |
           IDENTIFICADOR "-=" expresion {printf("asignacion con resta\n");} |
           IDENTIFICADOR "*=" expresion {printf("asignacion con multiplicacion\n");} |
           IDENTIFICADOR "/=" expresion {printf("asignacion con division\n");} |
           FUN '(' expresion ')' {$$ = $1->valor.func($3);} ;
%%

void yyerror(const char *s){
	printf("%s\n\n",s);
	return;
}



