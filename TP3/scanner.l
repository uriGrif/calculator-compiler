%{
    #include <stdio.h>
    #include "parser.h"
%}


%option header-file="scanner.h"
%option outfile="scanner.c"
%option nounput
%option noinput


%%

salir                                                       return PALABRA_RESERVADA_SALIR;
var                                                         return PALABRA_RESERVADA_VAR;




"+="                                                        return MAS_IGUAL;
"-="                                                        return MENOS_IGUAL;
"*="                                                        return POR_IGUAL;
"/="                                                        return DIVIDIDO_IGUAL;

%%