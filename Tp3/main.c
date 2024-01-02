#include <stdio.h>
#include "parser.h"

int main(void)
{	
	switch( yyparse() ) {
		case 0: //printf("\nCompilación terminada con éxito");
			break;		
		case 1: //printf("\nErrores de compilación");
			break;
		case 2:	//printf("\nNo hay memoria suficiente");
			break;		
		}

	return 0;		
}