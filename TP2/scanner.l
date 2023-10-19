%{
#include <stdio.h>
#include "tokens.h"
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
salir                                                       return PALABRA_RESERVADA_SALIR;
var                                                         return PALABRA_RESERVADA_VAR;
{letra}({digito}|{letra})*                                  return IDENTIFICADOR;
{digito}+                                                   |
{frac}{expo}?                                               |
{digito}+{expo}                                             return NUMERO;                 
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
{otro}+                                                     printf("Error lexico: cadena desconocida: %s\n",yytext);
{letra}({digito}|{letra})*{otro}+({digito}|{letra}|{otro})* printf("Error lexico: identificador invalido: %s\n",yytext);
{digito}+{letra}+({digito}|{letra})*                        printf("Error lexico: constante invalida: %s\n",yytext);
{frac}({inval}|{letra})+{expo}?({inval}|{letra})*                                   printf("Error lexico: REAL invalido: %s\n",yytext);
\n                                                          return NUEVA_LINEA;
%%