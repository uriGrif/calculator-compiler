#ifndef CALCULADORA_H_INCLUDED
#define CALCULADORA_H_INCLUDED

enum tipo {NUM, VARIABLE, FUNC};

struct simbolo_tabla{
    char * lexema;
    enum tipo tipo;
    union{
        double nro;
        double (*func)(double);

    }valor;
    struct simbolo_tabla * sig;
};
 // POR AHORA IMPLEMENTO COMO LINKED LIST

extern struct simbolo_tabla* tabla_de_simbolos;

extern int nsemnterrs;


struct simbolo_tabla* agregar_simbolo(char* nombre, enum tipo tipo);
struct simbolo_tabla* obtener_simbolo(char * nombre);

void inicializar_tabla(void);

int declarar(char *nombre);

#endif