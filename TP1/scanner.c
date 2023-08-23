#include <ctype.h>
#include<stdio.h>
#include "scanner.h"



char lexema[200];

enum estados {
    INICIAL,
    RECON_ID,
    RECON_CONST,
    ARRANCA_CERO,
    RECON_HEXA,
    RECON_CONST_MAL,
    ID_OK,
    CONST_OK,
    HEXA_OK,
    FDT_OK,
    ERR_CONST_MAL,
    RECON_ERR_GRAL,
    ERR_GRAL,
    ESCAPE
};



enum columnas {
    CARACTER_CERO,
    DIGITS_1_AL_9,
    LETRAS_HEXA,
    EQUIS,
    LETRAS_NO_HEXA,
    FDTEXT,
    ESPACIO,
    OTROS
};


enum estados TABLA_TRANSICION[13][8] = {
    {ARRANCA_CERO, RECON_CONST, RECON_ID, RECON_ID, RECON_ID, FDT_OK, INICIAL, RECON_ERR_GRAL},
    {RECON_ID, RECON_ID, RECON_ID, RECON_ID, RECON_ID, ID_OK, ID_OK, ID_OK},
    {RECON_CONST, RECON_CONST, RECON_CONST_MAL, RECON_CONST_MAL, RECON_CONST_MAL, CONST_OK, CONST_OK, CONST_OK},
    {RECON_CONST, RECON_CONST, RECON_CONST_MAL, RECON_HEXA, RECON_CONST_MAL, CONST_OK, CONST_OK, CONST_OK},
    {RECON_HEXA, RECON_HEXA, RECON_HEXA, HEXA_OK, HEXA_OK, HEXA_OK, HEXA_OK, HEXA_OK},
    {RECON_CONST_MAL, RECON_CONST_MAL, RECON_CONST_MAL, RECON_CONST_MAL, RECON_CONST_MAL, ERR_CONST_MAL, ERR_CONST_MAL, ERR_CONST_MAL},
    {ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE},
    {ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE},
    {ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE},
    {ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE},
    {ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE},
    {ERR_GRAL, ERR_GRAL, ERR_GRAL, ERR_GRAL, ERR_GRAL, ERR_GRAL, ERR_GRAL, RECON_ERR_GRAL},
    {ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE, ESCAPE}
};

int aceptor(enum estados estado){
    return estado >= 6 && estado<=9;
}

int centinela(enum estados estado){
    return estado >=6 && estado <=8 || estado == 10 || estado == 12;
}

int debo_parar(enum estados estado){
    return aceptor(estado) || centinela(estado);
}

enum columnas categoria_lexica(int caracter){
    if(caracter == '0') return CARACTER_CERO;
    if(isdigit(caracter)) return DIGITS_1_AL_9;
    if(isxdigit(caracter)) return LETRAS_HEXA;
    if(caracter == 'x' || caracter == 'X') return EQUIS;
    if(isalpha(caracter)) return LETRAS_NO_HEXA;
    if(caracter == EOF) return FDTEXT;
    if(isspace(caracter)) return ESPACIO;
    return OTROS;
}

enum token scanner(void) {
    enum estados estado = INICIAL;
    int caracter;
    int indice_lexema = 0;
    enum token t;
    while(!debo_parar(estado)){
       caracter =  getchar();
       estado = TABLA_TRANSICION[estado][categoria_lexica(caracter)];
        if(!isspace(caracter)){
            if(centinela(estado)) lexema[indice_lexema] = '\0';
            else lexema[indice_lexema] = caracter;
            indice_lexema++;
        } /*ARMAR EL LEXEMA*/
    }
    if(centinela(estado)) ungetc(caracter,stdin);
    switch (estado)
    {
    case ID_OK:
        t= IDENTIFICADOR;
        break;
    case CONST_OK:
        t= ENTERO;
        break;
    case HEXA_OK:
        t= HEXA;
        break;
    case FDT_OK:
        t= FDT;
        break;
    case ERR_CONST_MAL:
        t= ERROR_ENTERO;
        break;
    case ERR_GRAL:
        t= ERROR_GRAL;
        break;
    default:
        break;
    }
 return t;
}

