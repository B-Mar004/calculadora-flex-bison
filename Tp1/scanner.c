#include "scanner.h"

char caracter;

int estadoActual = 0;
int estadoAnterior = 0;
int columna=0;


int matrizEstados[][8] = {
    {1, 3, 7, 1, 1, 10, 0, 12}, //0
    {1, 1, 1, 1, 1, 10, 2,  2}, //1
    {99,99,99,99,99,99,99,99 }, //2 ID
    { 5, 3, 3, 5, 5, 4, 4, 4 }, //3 
    {99,99,99,99,99,99,99,99 }, //4 INT
    { 5, 5, 5, 5, 5, 5, 6, 6 }, //5
    {99,99,99,99,99,99,99,99 }, //6 ERR INT
    { 5, 3, 3, 8, 5, 5, 4, 4 }, //7
    {9, 8, 8, 10, 8, 10, 9,9}, //8
    {99,99,99,99,99,99,99,99 }, //9 HEXA
    {10,10,10,10,10,10,11,11 }, //10
    {99,99,99,99,99,99,99,99 }, //11 ERR GRAL
    {99,99,99,99,99,99,99,99 }  //12 FIN
};

const bool estados[13] = {false, false, true, false, true, false, true, false, false, true, false, true, true};



bool parar(){
    return estados[estadoActual];
}

int cambio(){
     
    //printf("Caracter: %c\n", caracter);
    if(isdigit(caracter)){
        if(caracter == '0'){
            estadoAnterior = estadoActual;
            return matrizEstados[estadoActual][CERO];
        }
            
         estadoAnterior = estadoActual;
        return matrizEstados[estadoActual][DIGITO];
    }
    if(isalpha(caracter)){
        
        if((caracter == 'x' || caracter == 'X') && estadoActual == 7){

            estadoAnterior = estadoActual;
            return matrizEstados[estadoActual][EQUIS];
        }
            
       
        if(isxdigit(caracter) && estadoActual == 8){
            
            estadoAnterior = estadoActual;
            return matrizEstados[estadoActual][LETRAHEXA];
        }
            
        estadoAnterior = estadoActual;
        return matrizEstados[estadoActual][LETRA];
    }
    if(isspace(caracter)){

        estadoAnterior = estadoActual;
        return matrizEstados[estadoActual][ESPACIO];
    }
        
    
    if(caracter == EOF){

        estadoAnterior = estadoActual;
        return matrizEstados[estadoActual][FDT];
    }
    columna = OTRO;
    estadoAnterior = estadoActual;
    return matrizEstados[estadoActual][OTRO];
}


token_t limpiar(token_t t){

    

    for(int i=0;i<100;i++) 
        t.lexema[i] = '\0';
    return t;
}


int tokenReconocido(){
    switch(estadoActual){
        case 2:
            ungetc(caracter, stdin);
            return IDENTIFICADOR;

        case 4:
            ungetc(caracter, stdin);
            return ENTERO;
        
        case 6:
            ungetc(caracter, stdin);
            return ERRORENTERO;
        
        case 9:
            ungetc(caracter, stdin);
            return HEXADECIMAL;
        
        case 11:
            ungetc(caracter, stdin);
            return ERRORGRAL;
        
        case 12:
            return FIN;        
    }
}


token_t scanner(){
    token_t token;
    int i = 0;
    token = limpiar(token);
    do{

        caracter = getchar();
        estadoActual = cambio();

        if(estadoActual == 4){  //ENTERO

            if(columna != OTRO){
                if(caracter !=  EOF && !isspace(caracter)){
                    token.lexema[i] = caracter;
                    i++;
                }
            }else{
                //No hago nada, no lo ingreso
            }
            
        }else if(estadoActual == 9){ //HEXADECIMAL

            if(isxdigit(caracter)){
               if(caracter !=  EOF && !isspace(caracter)){
                    token.lexema[i] = caracter;
                    i++;
                }
            }
            else{
               //No hago nada, no lo ingreso
            }
           
        
        }else{          //CUALQUIER OTRA COSA
            if(caracter !=  EOF && !isspace(caracter)){
                    token.lexema[i] = caracter;
                    i++;
            }
        } 
        
    }while(!parar());
    token.tipo = tokenReconocido();
    estadoActual = 0;

    return token;
}