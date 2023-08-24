#include <stdio.h>
#include "scanner.h"

char* nombre_token(enum token t){
    char* nombre;
    switch (t)
    {
    case IDENTIFICADOR:
        nombre = "Identificador";
        break;
    case ENTERO:
        nombre = "Entero";
        break;
    case HEXA:
        nombre = "Hexadecimal";
        break;
    case ERROR_ENTERO:
        nombre = "Entero Mal formado";
        break;
    case ERROR_GRAL:
        nombre = "Error general";
        break;
    }
    return nombre;
}

int main(void) {
    enum token token;
    token = scanner();
    while(token != FDT){
        printf("%s '%s' \n",nombre_token(token),lexema);
        token = scanner();
    }   

return 0;

}


