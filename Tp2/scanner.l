

%{
#include "tokens.h"
%}


%{
	int errlex;
	char msg[120];
%}

%option header-file="scanner.h"
%option outfile="scanner.c"
%option noinput nounput nodefault


Digito					[0-9]				
Real 					[0-9]+\.[0-9]*|[0-9]*\.[0-9]+	
Letra					[a-zA-Z]
Letra_Digito			[a-zA-z]|[0-9]
Otros 					[[:punct:]]{-}[(),+\-*/]

%%

"var"           { return PALABRA_RESERVADA; }
"salir"         { return FIN; }
"sin"           { return FUNCION; }
"cos"           { return FUNCION; }
"tan"           { return FUNCION; }
"asin"          { return FUNCION; }
"acos"          { return FUNCION; }
"atan"          { return FUNCION; }
"sqrt"          { return FUNCION; }
"log"           { return FUNCION; }

[+\-*/^=()]     { return OPERADOR; }
[0-9]+          { return NUMERO; }
[0-9]+\.[0-9]*|[0-9]*\.[0-9]+ { return REALES; }
[a-zA-Z][a-zA-Z0-9]* { return IDENTIFICADOR; }

\n              { return '\n'; }
[ \t]           ; // Ignorar espacios y tabuladores

{Otros}+													{ return ERROR_LEXICO_CADENAS;}
{Letra}{Letra_Digito}*{Otros}+({Letra_Digito}|{Otros})*		{ return ERROR_LEXICO_IDENTIFICADOR;}
{Digito}+{Letra}+{Letra_Digito}*							{ return ERROR_LEXICO_CONSTANTES;}
{Real}{Otros}*{Letra_Digito}*{Otros}*{Letra_Digito}*						{ return ERROR_LEXICO_REALES; }     

.                {sprintf(msg, "Error Símbolo no reconocido ");}

