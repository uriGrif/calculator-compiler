#include <stdio.h>
#include<string.h>
#include<stdlib.h>
#include<math.h>
#include "parser.h"
#include "calculadora.h"



//BUSCA EN LA LISTA UN REGISTRO CON ESE LEXEMA DE NOMBRE SI LO ENCUENTRA LO DEVUELVE, SI NO DEVUELVE 0
struct simbolo_tabla* obtener_simbolo(char * nombre){
    struct simbolo_tabla* aux = tabla_de_simbolos;
    while (aux != 0){
        if(!strcmp(nombre, aux->lexema)) return aux;  
        aux = aux->sig;
    }
    return 0;
}


//ESTE EJEMPLO AGREGA AL PRINCIPIO DE LA LISTA, SE PODRIA HACER AGREGANDO AL FINAL Y TE DEVUELVE EL PUNTERO AL OBJETO AGREGADO
struct simbolo_tabla* agregar_simbolo(char* nombre, enum tipo tipo){
    struct simbolo_tabla* aux = malloc(sizeof(struct simbolo_tabla));
    // aux->lexema = malloc(strlen(nombre) + 1);
    // strcpy(aux->lexema,nombre);
    aux->lexema = strdup(nombre);
    aux->tipo = tipo;
    aux->valor.nro = 0; // ???/
    aux->sig = tabla_de_simbolos;
    tabla_de_simbolos = aux;
    return aux;

// TODO YA ESTA DECLARADO
}

struct reg_funcion
{
  char *nombre;
  double (*func)();
};

struct reg_funcion funciones_aritmeticas[]
  = {
      {"sin", sin},
      {"cos", cos},
      {"tan",tan},
      {"asin",asin},
      {"acos",acos},
      {"atan", atan},
      {"log", log},
      {"sqrt", sqrt},
      {0, 0}
    };

struct reg_constante{
    char * nombre;
    double valor;
};

struct reg_constante constantes[]= {{"e",M_E},{"pi",M_PI},{0,0}};


// me devuelve si un ID ya fue declarado
int fue_declarado(char * nombre){
    return obtener_simbolo(nombre) != 0;
}

int declarar(char * nombre){
    if(fue_declarado(nombre)) {
        yyerror("Error, identificador ya declarado como variable");
        nsemnterrs++;
        return 1;
    }
    agregar_simbolo(nombre,VARIABLE);
    return 0;
}

void inicializar_tabla(void){
    struct simbolo_tabla * aux;
    for(int i=0;funciones_aritmeticas[i].nombre != 0; i++){
        aux = agregar_simbolo(funciones_aritmeticas[i].nombre,FUNC);
        aux->valor.func = funciones_aritmeticas[i].func;
    }
    for(int i=0;constantes[i].nombre !=0 ; i++){
        aux = agregar_simbolo(constantes[i].nombre,VARIABLE);
        aux->valor.nro = constantes[i].valor;
    }
}
