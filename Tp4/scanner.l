%top{
	#include <stdio.h>
	#include "parser.h"
	#include "calc.h"
}

%{
	int errlex;
	char msg[120];
%}

%option noinput nounput nodefault
%option yylineno
%option header-file="scanner.h"
%option outfile="scanner.c"

Digito					[0-9]				
Real 					[0-9]+\.[0-9]*|[0-9]*\.[0-9]+	
Letra					[a-zA-Z]
Letra_Digito			[a-zA-z]|[0-9]
Otros 					[[:punct:]]{-}[(),+\-*/]


%%
				

"programa"          return PROGRAMA; 
"salir"             return FIN; 
"var"            	return DEFINIR; 
"pi"				return CONSTPI;
"e"					return CONSTE;
"sin"|"cos"|"tan"|"asin"|"acos"|"atan"|"sqrt"|"log" {  yylval.str = strdup(yytext); return FUNCION; }

{Digito}+         							{ yylval.val = atof(yytext); return NUMERO; }
{Real}										{ yylval.val = atof(yytext); return NUMERO; }
{Letra}{Letra_Digito}* 						{ yylval.str = strdup(yytext); return IDENTIFICADOR;}

[ \t]+           ; // Ignorar espacios y tabuladores
"("															return '(';
")"															return ')';
","															return ',';
"+"															return '+';
"-"															return '-';
"*"															return '*';
"/"															return '/';
";"															return ';';
"^"															return '^';
"="															return ASIGNACION;
"\+="														return MAS_IGUAL;
"*="														return X_IGUAL;
"\n"														return '\n';

{Otros}+													{yylval.str = strdup(yytext); return ERROR_LEXICO_CADENAS;}
{Letra}{Letra_Digito}*{Otros}+({Letra_Digito}|{Otros})*		{yylval.str = strdup(yytext); return ERROR_LEXICO_IDENTIFICADOR;}
{Digito}+{Letra}+{Letra_Digito}*							{yylval.str = strdup(yytext); return ERROR_LEXICO_CONSTANTES;}
{Real}{Otros}*{Letra_Digito}*{Otros}*{Letra_Digito}*						{ yylval.str = strdup(yytext); return ERROR_LEXICO_REALES; }     

.                {sprintf(msg, "Error léxico: Símbolo no reconocido: %s", yytext); yyerror(msg);}


%%
