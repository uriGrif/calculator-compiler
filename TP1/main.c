#include <stdio.h>
#include "scanner.h"

int main(void) {
    token token;
    
    token = scanner();
    while(token != FDT){
        printf("%s '%s' \n", nombre_token(token), lexema);
        token = scanner();
    }
    
    return 0;
}

