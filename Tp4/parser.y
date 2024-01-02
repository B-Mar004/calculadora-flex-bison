%{
	#include <stdio.h>
	#include "scanner.h"
    #include "calc.h"

    typedef double tipoValor;
    int esVar = 0;

%}


%union {
    double val;
    char* str;
}


%type <val> expresion
 
%type <val> valor
%type <val> errores
%type <val> error
%type <val> asignacion
%type <val> llamadaFuncion
%type <str> IDENTIFICADOR
%type <str> ERROR_LEXICO_REALES
%type <str> ERROR_LEXICO_CADENAS
%type <str> ERROR_LEXICO_CONSTANTES
%type <str> ERROR_LEXICO_IDENTIFICADOR
%type <val> NUMERO
%type <str> FUNCION

%code provides {
	void yyerror(const char *);
	extern int errlex;
	extern int yynerrs;
}



%defines "parser.h"					
%output "parser.c"

%start programa
%define parse.error verbose

%token PROGRAMA PALABRA_RESERVADA OPERADOR NUMERO IDENTIFICADOR FIN DEFINIR  REAL 
%token ERROR_LEXICO_CADENAS ERROR_LEXICO_CONSTANTES ERROR_LEXICO_IDENTIFICADOR ERROR_LEXICO_REALES
%token ASIGNACION MAS_IGUAL X_IGUAL
%token CONSTE CONSTPI
%token FUNCION


%left '+' '-'
%left '*' '/'
%left '^'
%left '='
%precedence NEG
%left MAS_IGUAL X_IGUAL ASIGNACION

%%

programa : listaSentencias FIN
         ;

listaSentencias : sentencia
               | sentencia listaSentencias
               ;

sentencia : '\n'
          | expresion '\n'  { if(esVar){esVar = 0;}else{imprimir($1);} }                     
          | errores '\n'
          | error '\n'          {yyerrok;}
          ;

expresion : valor
          | '-' valor %prec NEG                                                         { $$ = -$2; }
          | '(' expresion ')'                                                           { $$ = $2; } 
          | expresion '+' expresion                                                     { $$ = realizarOperacion($1, $3, '+'); }
          | expresion '-' expresion                                                     { $$ = realizarOperacion($1, $3, '-'); }
          | expresion '*' expresion                                                     { $$ = realizarOperacion($1, $3, '*'); }
          | expresion '/' expresion                                                     { if($3 == 0){ yyerror("No es posible la división por 0"); YYERROR;}else{$$ = realizarOperacion($1, $3, '/'); } }
          | expresion '^' expresion                                                     { $$ = realizarOperacion($1, $3, '^');  }
          | asignacion
          | llamadaFuncion
          ;

asignacion :DEFINIR IDENTIFICADOR                                                       { if(idYaDefinido($2)){ yyerror("Error, identificador ya declarado como variable"); YYERROR; }else{definirVariable($2, 0); imprimirVar($2, 0); esVar = 1;}}
          | DEFINIR IDENTIFICADOR ASIGNACION expresion                                  { if(idYaDefinido($2)){ yyerror("Error, identificador ya declarado como variable"); YYERROR; }else{ definirVariable($2, $4); imprimirVar($2, $4); esVar = 1;}}
          | IDENTIFICADOR ASIGNACION expresion                                          { Nodo* varAux = obtenerVariable($1); if(varAux == NULL){ printf("No existe la variable %s", $1); YYERROR;}else{ $$ = asignarValorAVar($1, $3, 0); }  }
          | IDENTIFICADOR MAS_IGUAL expresion                                           { Nodo* varAux = obtenerVariable($1); if(varAux == NULL){ printf("No existe la variable %s", $1); YYERROR;}else{ $$ = asignarValorAVar($1, $3, 1); }  }
          | IDENTIFICADOR X_IGUAL expresion                                             { Nodo* varAux = obtenerVariable($1); if(varAux == NULL){ printf("No existe la variable %s", $1); YYERROR;}else{ $$ = asignarValorAVar($1, $3, 2); } }
          ;

llamadaFuncion : FUNCION '(' expresion ')'                                              { $$ = manejoDeFunciones($1, $3); }

valor : IDENTIFICADOR   { Nodo* varAux = obtenerVariable($1); if(varAux == NULL){ imprimirErrorVar($1); YYERROR;};$$ = varAux->id.valor; }
      | NUMERO          { $$ = $1; }
      | CONSTE          { $$ = 2.718281828; }
      | CONSTPI         { $$ = 3.14159; }
      ;

errores : ERROR_LEXICO_CADENAS          {printf("Error léxico: cadena desconocida: %s\n\n", $ERROR_LEXICO_CADENAS); }
        | ERROR_LEXICO_CONSTANTES       {printf("Error léxico: constante inválida: %s\n\n", $ERROR_LEXICO_CONSTANTES); }
        | ERROR_LEXICO_IDENTIFICADOR    {printf("Error léxico: identificador inválido: %s\n\n",$ERROR_LEXICO_IDENTIFICADOR );}
        | ERROR_LEXICO_REALES           {printf("Error léxico: real inválido: %s\n\n", $ERROR_LEXICO_REALES); }
        ;
%%


void yyerror(const char* s) {
    printf("%s\n", s);
    
}

