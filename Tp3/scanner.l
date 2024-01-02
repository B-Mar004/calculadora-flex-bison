%top{
	#include <stdio.h>
	#include "parser.h"
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
				

"programa"            {return PROGRAMA; }
"salir"             {return FIN; }
"var"            {return DEFINIR; }
"pi"				return IDENTIFICADOR;
"sin"|"cos"|"tan"|"asin"|"acos"|"atan"|"sqrt"|"log" { return FUNCION; }
{Digito}+         							 { yylval = strdup(yytext); return NUMERO; }
{Real}			 { yylval = strdup(yytext); return NUMERO; }
{Letra}{Letra_Digito}* 			{yylval = strdup(yytext); return IDENTIFICADOR;}

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
"="															{return ASIGNACION;}
"\+="														{return MAS_IGUAL;}
"\n"														return '\n';

{Otros}+													{yylval = strdup(yytext); return ERROR_LEXICO_CADENAS;}
{Letra}{Letra_Digito}*{Otros}+({Letra_Digito}|{Otros})*		{yylval = strdup(yytext); return ERROR_LEXICO_IDENTIFICADOR;}
{Digito}+{Letra}+{Letra_Digito}*							{yylval = strdup(yytext); return ERROR_LEXICO_CONSTANTES;}
{Real}{Otros}*{Letra_Digito}*{Otros}*{Letra_Digito}*						{ yylval = strdup(yytext); return ERROR_LEXICO_REALES; }     

.                {sprintf(msg, "Error léxico: Símbolo no reconocido: %s", yytext); yyerror(msg);}


%%
