#ifndef SCANNER_H_INCLUDED
#define SCANNER_H_INCLUDED

enum token
{
    IDENTIFICADOR,
    ENTERO,
    HEXA,
    FDT,
    ERROR_GRAL,
    ERROR_ENTERO
};
extern char lexema[200];
enum token scanner(void);

#endif