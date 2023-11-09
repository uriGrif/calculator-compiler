%{
#include <stdio.h>
#include "parser.h"
%}

%option header-file="scanner.h"
%option outfile="scanner.c"
%option nounput
%option noinput

digito [0-9]
letra [a-zA-Z]
expo [eE][+-]?{digito}+
frac {digito}*\.{digito}+|{digito}+\.{digito}*
inval [0-9.]
otro [[:punct:]]{-}[()+\-/*^]

%%
salir                                                       return SALIR;
var                                                         return VAR;
{letra}({digito}|{letra})*                                  return IDENTIFICADOR;
{digito}+{expo}?                                            |
{frac}{expo}?                                               return NUMERO;             
"+="                                                        return MAS_IGUAL;
"-="                                                        return MENOS_IGUAL;
"*="                                                        return POR_IGUAL;
"/="                                                        return DIVIDIDO_IGUAL;
"="                                                         return '=';
"("                                                         return '(';
")"                                                         return ')';
"+"                                                         return '+';
"*"                                                         return '*';
"-"                                                         return '-';
"/"                                                         return '/';
"^"                                                         return '^'; 
{letra}({digito}|{letra})*{otro}+({digito}|{letra}|{otro})* printf("Error lexico: identificador invalido: %s\n",yytext);
{digito}+{expo}({letra}|{otro})({digito}|{letra}|{otro})*   |
{frac}({inval}|{letra}|{otro})+{expo}?({inval}|{letra}|{otro})*  printf("Error lexico: REAL invalido: %s\n",yytext);
{digito}+({letra}|{otro})({digito}|{letra}|{otro})*         printf("Error lexico: constante invalida: %s\n",yytext);
{otro}+                                                     printf("Error lexico: cadena desconocida: %s\n",yytext);
\n                                                          return NUEVA_LINEA;
" "                                                         ;
%%