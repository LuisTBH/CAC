    #include "mpi.h"
    #include <stdio.h>

    #define MAXV 10000

    int main( int argc, char *argv[] )
    {

        int idproc, numprocs;
        double a[MAXV], b[MAXV], /* vectores operando */
               prod, /* producto escalar */
           datoa, datob, /* datos recibidos en cada proc */
           dato, resultado; /* producto enviado al 0 */
        int vsize, /* tam vectores */
            cadaproc, /* lo que le toca a cada proc */
        resto, /* el resto lo har�el cero */
        i, j, k;
        MPI_Status status;

        MPI_Init (&argc, &argv );
        MPI_Comm_rank ( MPI_COMM_WORLD, &idproc );
        MPI_Comm_size ( MPI_COMM_WORLD, &numprocs );

        if (idproc == 0) {
           printf("Tam. vectores (menor que %d):",MAXV);
           scanf("%d", &vsize);
           printf("\nGenerando datos...\n");
           for (i=0; i<vsize; i++) {
             a[i]=(double) i;
         b[i]=(double) i;
           }
           cadaproc = vsize / (numprocs-1);
           resto = vsize % (numprocs-1);

           k=0;

           /*Difundimos lo que le toca a cada procesador */
            MPI_Bcast(&cadaproc, 1, MPI_INT, 0, MPI_COMM_WORLD);

           for (i=1; i<numprocs; i++) {

              printf("Soy %d. Enviando a %d el dato %d\n",idproc, i, cadaproc);

                /* Enviamos a cada procesador los datos que le tocan */
                MPI_Send(&a[k], cadaproc, MPI_DOUBLE, i, 1, MPI_COMM_WORLD);
                MPI_Send(&b[k], cadaproc, MPI_DOUBLE, i, 1, MPI_COMM_WORLD);
                printf("Soy %d. Enviando a %d los datos %lf y %lf\n",idproc, i, a[k], b[k]);
                k = k + cadaproc;

           }
           /* el resto lo hace el cero */
           prod =0;
           for (j=0; j<resto; j++) {
             prod = prod+(a[k]*b[k]);
         k++;
           }

        }
        else {

        /* When all of the receiver processes call MPI_Bcast, the data variable will be filled in with the data from the root process. */
        MPI_Bcast(&cadaproc, 1, MPI_INT, 0, MPI_COMM_WORLD);
        prod = 0;

             MPI_Recv(&a, cadaproc, MPI_DOUBLE, 0, 1, MPI_COMM_WORLD, &status);
             MPI_Recv(&b, cadaproc, MPI_DOUBLE, 0, 1, MPI_COMM_WORLD, &status);
             printf("Soy %d. Recibiendo de %d los datos %lf y %lf \n",idproc, status.MPI_SOURCE, datoa, datob);

        for(k=0; k<cadaproc; k++) {
             prod = prod + (a[k]*b[k]);
        }


        }

         MPI_Reduce(&prod, &resultado, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
        if(idproc == 0) {
         printf("El producto escalar es %f\n", resultado);
        }

        MPI_Finalize();
        return 0;
    }
