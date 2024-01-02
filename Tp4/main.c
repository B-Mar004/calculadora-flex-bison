#include <stdio.h>
#include "calc.h"
#include "parser.h"

int main(void){


    yyparse();
    return 0;
}