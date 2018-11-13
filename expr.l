%{
#include "expr.tab.h"
%}

delim	[ \t\n\r ]
ws	{delim}+
digito	[0-9]
num	{digito}+(\.{digito}*(E[+-]?{digito}+)?)?
letra	[a-zA-Z_]

%%

"+"	{return TADD;}
"-"	{return TSUB;}
"*"	{return TMUL;}
"/"	{return TDIV;}
"("	{return TAPAR;}
")"	{return TFPAR;}
"{" {return TACHAVE;}
"}" {return TFCHAVE;}
"," {return TVIRGULA;}
"=" {return IGUAL;}
";" {return PV;}

"float" {return FLOAT; }
"int"	{return INT; }
"if" {return IF; }
"return" {return RETURN; }
{letra}?\"(\\.|[^\\"])*\"	{return(STRING); }
"else" {return ELSE; }
"while" {return WHILE; }
"read" {return READ;}
"void" {return VOID; }
"print" {return PRINT;}


"<" {return MENOR; }
">"	{return MAIOR; }
"<=" {return MENORIGUAL; }
">=" {return MAIORIGUAL; }
"==" {return IGUALIGUAL; }
"!=" {return DIFERENTE; }
"&&" {return BE; }
"||" {return BOU;}
"!"	 {return NEGACAO; }
"~"	{return NEGACAO; }

{num}	{yylval=atof(yytext); return TNUM;}
{letra}({letra}|{digito})* {return ID;}
{ws}	{}
