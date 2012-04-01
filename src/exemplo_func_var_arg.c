#include "node.h"
#include <stdarg.h>


/**
 * Exemplo de implementação de uma função variádica.
 *
 * A chamada
 *     print_strings(3.14, 42, "oi", "teste", "123", NULL);
 * imprime as seguintes linhas:
 *     Recebi um 'oi'
 *     Recebi um 'teste'
 *     Recebi um '123'
 *     Recebi ao todo 3 args variadicos.
 *
 * @param arg0: First argument of `print_strings`.
 * @param args: NULL-terminated list of char* arguments.
 * @return Nothing.
 */
NULL_TERMINATED
void print_strings(double x, int y,  /* const char* args */ ...) {
    va_list ap;
    va_start(ap, y);

    int n_args = 0;
    const char* arg = va_arg(ap, const char*);
    for (;  arg != NULL;  arg = va_arg(ap, const char*)) {
        printf("Recebi um '%s'\n", arg);
        n_args ++;
    }
    printf("Recebi ao todo %d args variadicos.\n", n_args);
    va_end(ap);
}
