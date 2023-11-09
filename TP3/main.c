#include <stdio.h>
#include "parser.h"

int yylexerrs = 0;
int main(void){

    switch( yyparse() ){
        case 0: printf("Pertenece al LIC");
            break;
        case 1: printf("No pertenece al LIC");
            break;
        case 2: printf("Memoria Insuficiente");
            break;

    }
}