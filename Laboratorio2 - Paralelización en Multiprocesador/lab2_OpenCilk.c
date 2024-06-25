#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#define cilk_spawn _Cilk_spawn
#define cilk_sync  _Cilk_sync
#define cilk_for   _Cilk_for


// realiza la operación ( fila^3 + columna^3 ) / 2
int f(int fila, int columna) {
    int res = (fila * fila * fila + columna * columna * columna) / 2;
    return res;
}


int main() {
    int fils = 10000;
    int cols = 10000;


    // reserva memoria de matriz
    clock_t begin = clock();        // inicio medición de tiempo
    int** matriz = (int**) malloc(fils * sizeof(int*));
    for (int i = 0; i < fils; i++) {
        matriz[i] = (int*) malloc(cols * sizeof(int));
    }


    // llena la matriz
    cilk_for (int i = 0; i < fils; i++) {  // cilk_for
        for (int j = 0; j < cols; j++) {
            matriz[i][j] = f(i, j);
        }
    }
    clock_t end = clock();        // fin medición de tiempo
    // cálculo del tiempo de ejecución
    double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
    printf("Tiempo de ejecución: %f\n", time_spent);


    // libera la memoria de  matriz
    for (int i = 0; i < fils; i++) {
        free(matriz[i]);
    }
    free(matriz);
    return 0;
}
