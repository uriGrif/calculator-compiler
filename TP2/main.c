#include "scanner.h"
#include "tokens.h"

int main(void){
    enum token tok;
    char* token_names[]={"","IDENTIFICADOR", "NUMERO","salir","var","+=","-=","*=","/=","'NL'"};
    while ((tok = yylex())!=FDT){
        if(tok<=NUMERO){
            printf("Token: %s\t\t valor: %s\n",token_names[tok],yytext);
        }
        else if(tok <= NUEVA_LINEA){
            printf("Token: %s\n",token_names[tok]);
        }
        else{
            printf("Token: '%c'\n",tok);
        }
    }
    return 0;
}

