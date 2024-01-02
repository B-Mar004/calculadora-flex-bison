#ifndef SCANNER_H_INCLUDED
#define SCANNER_H_INCLUDED

#include <ctype.h>
#include <string.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

enum caracter
{
    LETRA,
    DIGITO,
    CERO,
    EQUIS,
    LETRAHEXA,
    OTRO,
    ESPACIO,
    FDT
};

enum reconocido{
    IDENTIFICADOR,
    ENTERO,
    HEXADECIMAL,
    ERRORGRAL,
    ERRORENTERO,
    FIN
};


typedef struct token{
    char lexema[100];
    int tipo;
} token_t;


token_t limpiar(token_t );

bool esUnaLetraHexa(char);
int cambio();
bool parar();
int tokenReconocido();
token_t scanner();


#endif //SCANNER_H_INCLUDED