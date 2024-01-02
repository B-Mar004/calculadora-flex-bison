%code top{
	#include <stdio.h>
	#include "scanner.h"

    int esVar = 0;
}

%code provides {
	void yyerror(const char *);
	extern int errlex;
	extern int yynerrs;
}

%define api.value.type{char *}

%defines "parser.h"					
%output "parser.c"

%start programa
%define parse.error verbose

%token PROGRAMA PALABRA_RESERVADA FUNCION OPERADOR NUMERO IDENTIFICADOR FIN DEFINIR  REAL ERROR_LEXICO_CADENAS ERROR_LEXICO_CONSTANTES ERROR_LEXICO_IDENTIFICADOR ERROR_LEXICO_REALES
%token ASIGNACION MAS_IGUAL

%left '+' '-'
%left '*' '/'
%left '^'
%left '='
%precedence NEG
%left MAS_IGUAL ASIGNACION

%%

programa : PROGRAMA listaSentencias { if (yynerrs || errlex) YYABORT; else YYACCEPT; }
         ;

listaSentencias : sentencia
               | sentencia listaSentencias
               ;

sentencia : '\n'
          | expresion '\n'  {if(esVar){esVar = 0;}else{printf("Expresión\n\n");}}
          | errores '\n'
          | error '\n'     {printf("\n");}
          ;

expresion : valor
          | '-' valor %prec NEG { printf("Cambio signo\n"); }
          | '(' expresion ')' { printf("Cierra paréntesis\n"); }
          | expresion '+' expresion { printf("Suma\n"); }
          | expresion '-' expresion { printf("Resta\n"); }
          | expresion '*' expresion { printf("Multiplicación\n"); }
          | expresion '/' expresion { printf("División\n"); }
          | expresion '^' expresion { printf("Potenciación\n"); }
          | llamadaFuncion      { printf("Función\n\n"); }
          | asignacion 
          ;

valor : IDENTIFICADOR { printf("ID\n"); }
      | NUMERO { printf("Número\n"); }
      ;


asignacion : IDENTIFICADOR ASIGNACION expresion { printf("Asignación\n"); }
          | IDENTIFICADOR MAS_IGUAL expresion { printf("Asignación con suma\n"); }
          | DEFINIR IDENTIFICADOR ASIGNACION expresion  { printf("Define ID como variable con valor inicial\n\n"); }
          | DEFINIR IDENTIFICADOR    { printf("Define ID como variable\n\n"); }
          ;

llamadaFuncion : FUNCION '(' expresion ')'

errores : ERROR_LEXICO_CADENAS       {printf("Error léxico: cadena desconocida: %s\n\n", $ERROR_LEXICO_CADENAS);}
        | ERROR_LEXICO_CONSTANTES    {printf("Error léxico: constante inválida: %s\n\n", $ERROR_LEXICO_CONSTANTES);}
        | ERROR_LEXICO_IDENTIFICADOR  {printf("Error léxico: identificador inválido: %s\n\n",$ERROR_LEXICO_IDENTIFICADOR );}
        | ERROR_LEXICO_REALES         {printf("Error léxico: real inválido: %s\n\n", $ERROR_LEXICO_REALES);}
        ;
%%


void yyerror(const char* s) {
    printf("linea #%d  %s\n", yylineno,s);
}

