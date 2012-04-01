#include <stdio.h>
#include <stdlib.h>

#include "node.h"

/* Programa principal do nico. */
char* progname;
int lineno;
extern FILE* yyin;

int main(int argc, char* argv[]) 
{
   if (argc != 2) {
     printf("uso: %s <input_file>. Try again!\n", argv[0]);
     exit(-1);
   }
   yyin = fopen(argv[1], "r");
   if (!yyin) {
     printf("Uso: %s <input_file>. Could not find %s. Try again!\n", 
         argv[0], argv[1]);
     exit(-1);
   }

   progname = argv[0];

   if (!yyparse()) 
      printf("OKAY.\n");
   else 
      printf("ERROR.\n");
   if (syntax_tree->type == int_node) 
     printf("A AST se limita a uma folha rotulada por: %s\n", 
        syntax_tree->lexeme);
   else
     printf("Something got wrong in the AST.\n");
   return(0);
}

yyerror(char* s) {
  fprintf(stderr, "%s: %s", progname, s);
  fprintf(stderr, "line %d\n", lineno);
}
