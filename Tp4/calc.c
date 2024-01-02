#include "calc.h"



Nodo* variables = NULL;

double definirVariable(char* var, double valor){

    Identificador variable;
   
    
    strcpy(variable.nombreVariable, var);
    variable.valor = valor;

    agregarALista(variable);

    return valor;
}

struct funciones
{
  char *nombre;
  double (*func)();

};


struct funciones funciones_aritmeticas[]= 
{
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

struct t_constantes{

    char* nombre;
    double valor;

};

bool idYaDefinido(char* var ){
    Nodo* aux = obtenerVariable(var);

    if(aux == NULL){
        return false;
    }

    return true;
}

void imprimirErrorVar(char *var){

    printf("Error ID %s no declarado\n", var);

}

double manejoDeFunciones(char* func, double valor){

   
    for(int i=0; i<8; i++){
        
        if(strcmp(func, funciones_aritmeticas[i].nombre)==0){
            
            return funciones_aritmeticas[i].func(valor);
        }
    }
   
    return 0;
}


void agregarALista(Identificador variable){

    Nodo* nuevoNodo = (Nodo*)malloc(sizeof(Nodo));
    Nodo* aux;
    strcpy(nuevoNodo->id.nombreVariable, variable.nombreVariable);
    nuevoNodo->id.valor = variable.valor;
    nuevoNodo->sig = NULL;

    if(variables == NULL){
        variables = nuevoNodo;
    }
    else{
        
        aux = variables;
        
        while(aux->sig != NULL){
            
            aux = aux->sig;
        }
      

        aux->sig = nuevoNodo;
        
    }

}


void imprimirVar(char* nombre, double valor){

    printf("> %s: %f\n", nombre, valor);

}

void imprimir(double valor){

    printf("> %f\n", valor);

}

double realizarOperacion(double n1, double n2, char operacion){

    double valor; 

    switch (operacion)
    {
    case '+':
        valor = n1 + n2;
        break;
    case '-':
        valor = n1 - n2;
        break;
    case '*':
        valor = n1 * n2;
        break;
    case '/': 
        valor = n1 / n2;
        break;
    case '^':
        valor = pow(n1, n2);
        break;
    default:
        printf("Operacion desconocida, cuidadito");
        break;
    }

    return valor;
}

double asignarValorAVar(char* var, double valor, int codOp){

    Nodo* varAux = obtenerVariable(var);

    switch (codOp)
    {
    case 0:     // =
        varAux->id.valor = valor;
        break;
    case 1:     // +=
        varAux->id.valor = varAux->id.valor + valor;
        break;
    case 2:     // *=
        varAux->id.valor = varAux->id.valor * valor;
        break;    
    default:
        printf("Operacion desconocida");
        break;
    }  

    return varAux->id.valor;
}

Nodo* obtenerVariable(char* nomVariable){

    Nodo* aux = variables;


    while(aux != NULL){
        
        if(strcmp(aux->id.nombreVariable, nomVariable) == 0){
            return aux;
        }


        aux = aux->sig;
    }

    return NULL;
}