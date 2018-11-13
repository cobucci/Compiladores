%{
#include <stdio.h>
#include <stdlib.h>
#define YYSTYPE double
%}

%token TADD TMUL TSUB TDIV TAPAR TFPAR TNUM TFIM TACHAVE TFCHAVE TVIRGULA ID
%token FLOAT INT STRING IF RETURN ELSE WHILE IGUAL READ PV VOID PRINT
%token MENOR MAIOR MENORIGUAL MAIORIGUAL IGUALIGUAL DIFERENTE BE BOU NEGACAO	


%%

Programa: ListaFuncoes BlocoPrincipal
	| BlocoPrincipal
	;

ExpressaoBool: ExpressaoBool BOU Marcador ExpressaoBool2
	| ExpressaoBool BE Marcador ExpressaoBool2
	| ExpressaoBool2
	;

ExpressaoBool2:	NOT ExpressaoBool2
	| TAPAR ExpressaoBool TFPAR
	| ExpressoBool2 ExpressaoRelacional ExpressaoBool2
	| ExpressaoAritmetica
	;

Marcador : {};

ExpressaoRelacional: MENOR | MAIOR | MENORIGUAL | MAIORIGUAL | IGUALIGUAL | DIFERENTE;

ExpressaoAritmetica: ExpressaoAritmetica TADD Termo {$$ = $1 + $3; printf(" +");}
	| ExpressaoAritmetica TSUB Termo {$$ = $1 - $3; printf(" -");}
	| Termo
	;


Termo: Termo TMUL Fator {$$ = $1 * $3;  printf(" *");}
	| Termo TDIV Fator {$$ = $1 / $3; printf(" /");}
	| Fator
	;

Fator: TNUM { printf("%f ", $1); }
	| TAPAR ExpressaoAritmetica TFPAR {$$ = $2;}
	;


ListaFuncoes: ListaFuncoes Funcao
	| Funcao
	;

Funcao: TipoRetorno ID TAPAR DeclParametros TFPAR BlocoPrincipal
	| TipoRetorno ID TAPAR TFPAR BlocoPrincipal
	;

TipoRetorno: Tipo
	| VOID
	;

DeclParametros: DeclParametros TVIRGULA Parametro
	| Parametro
	;

Parametro: Tipo ID
	;

BlocoPrincipal: TACHAVE Declaracoes ListaCmd TFCHAVE
	| TACHAVE ListaCmd TFCHAVE
	;

Declaracoes: Declaracoes Declaracao
	| Declaracao
	;

Declaracao: Tipo ListaId PV

Tipo: INT
| STRING
| FLOAT
;

ListaId: ListaId TVIRGULA ID
| ID
;

Bloco: TACHAVE ListaCmd TFCHAVE


ListaCmd : ListaCmd Comando
| Comando
;

Comando: CmdSe
| CmdEnquanto
| CmdAtrib
| CmdEscrita
| CmdLeitura
| ChamadaProc
| Retorno
;

Retorno : RETURN ExpressaoAritmetica PV
| RETURN STRING PV

CmdSe : IF TAPAR ExpressaoLogica TFPAR Bloco
 | IF TAPAR ExpressaoLogica TFPAR Bloco ELSE Bloco
 ;

 CmdEnquanto:  WHILE TAPAR ExpressaoLogica TFPAR Bloco

 CmdAtrib: ID IGUAL ExpressaoAritmetica PV
| ID IGUAL STRING PV

CmdEscrita : PRINT TAPAR ExpressaoAritmetica TFPAR PV
| PRINT TAPAR STRING TFPAR PV


CmdLeitura: READ TAPAR ID TFPAR PV


ChamadaProc: ChamadaFuncao PV


ChamadaFuncao : ID TAPAR ListaParametros TFPAR
| ID TAPAR TFPAR
;


ListaParametros : ListaParametros TVIRGULA ExpressaoAritmetica
| ListaParametros TVIRGULA STRING
| ExpressaoAritmetica
| STRING
;

ExpressaoLogica : ExpressaoAritmetica;









%%

#include "lex.yy.c"

int yyerror (char *str)
{
	printf("%s - antes %s\n", str, yytext);

}

int yywrap()
{
	return 1;
}
