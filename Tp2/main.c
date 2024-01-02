#include <stdio.h>
#include "tokens.h"

extern int yylex();
extern char* yytext;

int main() {
    int token;
    while ((token = yylex()) != 0) {
        switch (token) {
            case IDENTIFICADOR:
                printf("Token: Identificador\tlexema: %s\n", yytext);
                break;
            case FUNCION:
                printf("Token: Funcion\tlexema: %s\n", yytext);
                break;
            case OPERADOR:
                printf("Token: Operador\tlexema: %s\n", yytext);
                break;
            case NUMERO:
                printf("Token: Número\tlexema: %s\n", yytext);
                break;
            case '\n':
                printf("Token: 'NL'\n");
                break;
            case REALES:
                printf("Token: Número\tlexema: %s\n", yytext);
                break;
            case ERROR_LEXICO_CADENAS:
                printf("Error léxico: cadena inválida: %s\n", yytext);
                break;
            case ERROR_LEXICO_REALES:
                printf("Error léxico: real inválido: %s\n", yytext);
                break;
            case ERROR_LEXICO_CONSTANTES:
                printf("Error léxico: constante inválida: %s\n", yytext);
                break;
            case ERROR_LEXICO_IDENTIFICADOR:
                printf("Error léxico: identificador inválido: %s\n", yytext);
                break;
            case FIN:
                printf("Token: %s\n", yytext);
                break;
        }
    }
    return 0;
}
