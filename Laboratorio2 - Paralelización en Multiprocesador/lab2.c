#include <time.h>	// calcular tiempo
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
    clock_t inicio = clock();
    for (int i = 0; i < fils; i++) {
        for (int j = 0; j < cols; j++) {
            matriz[i][j] = f(i, j);
        }
    }

    clock_t fin = clock();
    
    // libera la memoria de  matriz
    for (int i = 0; i < fils; i++) {
        free(matriz[i]);
    }
    free(matriz);

    double tiempo = (double)(fin - inicio) / CLOCKS_PER_SEC;
    printf("Tiempo de ejecucición: %f segundos\n", tiempo);
    
    return 0;
}

