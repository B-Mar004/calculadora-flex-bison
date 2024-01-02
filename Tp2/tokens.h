// tokens.h

#ifndef TOKENS_H
#define TOKENS_H

typedef enum {
    FDT = 11,          // Fin de Archivo
    IDENTIFICADOR,
    PALABRA_RESERVADA,
    OPERADOR,
    CARACTER_PUNTUACION,
    FUNCION,
    NUMERO,
    REALES,
    ERROR_LEXICO_CADENAS,
    ERROR_LEXICO_CONSTANTES,
    ERROR_LEXICO_REALES,
    ERROR_LEXICO_IDENTIFICADOR,
    FIN
} TokenType;

#endif // TOKENS_H
