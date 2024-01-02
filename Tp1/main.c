#include "scanner.h"


int main(void){

    token_t leido;



    do{
        leido = scanner();
        switch(leido.tipo){
            case IDENTIFICADOR:
            printf("Identificador: '%s'\n", leido.lexema);
            break;
            case ENTERO:
            printf("Entero: '%s'\n", leido.lexema);
            break;
            case HEXADECIMAL:
            printf("Hexadecimal: '%s'\n", leido.lexema);
            break;
            case ERRORGRAL:
            printf("Error general: '%s'\n", leido.lexema);
            break;
            case ERRORENTERO:
            printf("Entero mal formado: '%s'\n", leido.lexema);
            
            break;

        }


    }while(leido.tipo != FIN);

}
