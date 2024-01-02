#ifndef CALC_H_INCLUDED
#define CALC_H_INCLUDED

#include <stdio.h>
#include <math.h>
#include <string.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct Identificador {
    char nombreVariable[30];
    double valor;
} Identificador;

typedef struct Nodo {
    Identificador id;
    struct Nodo* sig;
} Nodo;



extern Nodo* variables;

Nodo* obtenerVariable(char* );
double asignarValorAVar(char*,  double, int );
double realizarOperacion(double , double , char );
void agregarALista(Identificador );
double definirVariable(char*, double );
void imprimirVar(char* , double );
void imprimir(double );
void imprimirErrorVar(char *);
double manejoDeFunciones(char*, double );
bool idYaDefinido(char* );



#endif