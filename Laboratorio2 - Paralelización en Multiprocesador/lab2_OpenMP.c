#include <omp.h>  // para usar OpenMP
#include <stdio.h>
#include <stdlib.h>

int f(int fila, int columna) {
    int res = (fila * fila * fila + columna * columna * columna) / 2;
    return res;
}

int main() {
    int fils = 10000;
    int cols = 10000;

    // reserva memoria de matriz
    int** matriz = (int**)malloc(fils * sizeof(int*));
    for (int i = 0; i < fils; i++) {
        matriz[i] = (int*)malloc(cols * sizeof(int));
    }

    // llena la matriz
    double inicio = omp_get_wtime(); // inicio de la medición del tiempo
    #pragma omp parallel for
    for (int i = 0; i < fils; i++) {
        for (int j = 0; j < cols; j++) {
            matriz[i][j] = f(i, j);
        }
    }
    double fin = omp_get_wtime(); // fin de la medición del tiempo

    // libera la memoria de matriz
    for (int i = 0; i < fils; i++) {
        free(matriz[i]);
    }
    free(matriz);

    double tiempo = fin - inicio; // cálculo del tiempo de ejecución
    printf("Tiempo de ejecución: %f segundos\n", tiempo);

    return 0;
}

