#include <stdio.h>
#include <stdlib.h>

#include "expr.tab.c"

extern FILE *yyin;

int main(int argc, char *argv[]){

		FILE *arquivo = NULL;
	  if (argc < 2){
		  printf("ERRO!FALTAM ARGUMENTOS\n");
		  return 0;
	  }
	  if( (arquivo = fopen (argv[1], "r")) == NULL){
	    printf("ERRO AO ABRIR O ARQUIVO\n");
	    return 0;
	  }
		yyin = arquivo;
		yyparse();
		return 0;
}
