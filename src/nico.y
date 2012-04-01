%error-verbose

%{
  /* Aqui, pode-se inserir qualquer codigo C necessario ah compilacao
   * final do parser. Sera copiado tal como esta no inicio do y.tab.c
   * gerado por Yacc.
   */
  #include <stdio.h>
  #include <stdlib.h>
  #include "node.h"

%}

%union {
  char* cadeia;
  struct _node * no;
}


%token IDF
%token INT
%token DOUBLE
%token REAL
%token CHAR
%token QUOTE
%token SWAP
%token LE
%token GE
%token EQ
%token NE
%token AND
%token OR
%token NOT
%token IF
%token THEN
%token ELSE
%token WHILE
%token<cadeia> INT_LIT
%token F_LIT
%token END
%token TRUE
%token FALSE
%token STRING
%token CONST
%token STR_LIT

%type<no> code 
%type<no> acoes
%type<no> comando
%type<no> enunciado
%type<no> expr


%start code

 /* A completar com seus tokens - compilar com 'yacc -d' */

%%
code: declaracoes acoes
    | acoes { $$ = $1; syntax_tree = $$;  }
    ;

declaracoes: declaracao ';'
           | declaracoes declaracao ';'
           ;

declaracao: tipo ':' listadeclaracao 

listadeclaracao: IDF
               | IDF ',' listadeclaracao
               ;

tipo: tipounico 
    | tipolista
    ;

tipounico: INT
         | DOUBLE
         | REAL
         | CHAR
         ;

tipolista: INT '(' listadupla ')'
         | DOUBLE '(' listadupla ')'
         | REAL '(' listadupla ')'
         | CHAR '(' listadupla ')'
         ;

listadupla: INT_LIT ':' INT_LIT
          | INT_LIT ':' INT_LIT ',' listadupla
          ;

acoes: comando  { $$ = $1; }
     | comando acoes
     ;

comando: lvalue '=' expr ';'
       | lvalue SWAP lvalue ';'
       | expr ';'  { $$ = $1; }
       | bloco
       ;

lvalue: IDF
      | IDF '[' listaexpr ']'
      ;

listaexpr: expr
         | expr ',' listaexpr
         ;

expr: expr '+' expr  
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    | '(' expr ')'
    | INT_LIT  { $$ = create_node(@1.first_line, int_node, $1, NULL); } 
    | F_LIT    
    | lvalue
    | chamaproc
    ;

chamaproc: IDF '(' listaexpr ')'
         ;

enunciado: IF '(' expbool ')' THEN acoes fiminstcontrole
         | WHILE '(' expbool ')' '{' acoes '}'
         ;

fiminstcontrole: END
               | ELSE acoes END
               ;

expbool: TRUE 
       | FALSE
       | '(' expbool ')'
       | expbool AND expbool
       | expbool OR expbool
       | NOT expbool
       | expr '>' expr
       | expr '<' expr
       | expr LE expr
       | expr GE expr
       | expr EQ expr
       | expr NE expr
       ;
%%
 /* A partir daqui, insere-se qlqer codigo C necessario.
  */
