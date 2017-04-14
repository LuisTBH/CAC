
#include "mpi.h"
#include <stdio.h>
#define MAXITER 10
#define MAXSIZE 262144
char inmsg[MAXSIZE];
char outmsg[MAXSIZE];


int main( int argc, char *argv[] ) 
{
    int numtasks, rank, dest, source, rc, tag=1, partner, d;  
    int i, niter, length, namelen;
    double clock1, clock2, timee, bw;
    MPI_Status Stat;
    char processor_name[MPI_MAX_PROCESSOR_NAME];

    MPI_Init(&argc,&argv);
    MPI_Comm_size(MPI_COMM_WORLD, &numtasks);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Get_processor_name( processor_name, &namelen);

    fprintf( stderr, "Process %d is alive on %s\n", rank, processor_name
);

    for( i = 0; i < MAXSIZE; i++ )
	outmsg[i] = i % 256;

    for( length = 1; length <= MAXSIZE; length = 2*length ) {
      MPI_Barrier(MPI_COMM_WORLD);
      if( rank == 0 ) clock1 = MPI_Wtime();
      for( niter = 0; niter < MAXITER; niter++ ) {
        for( d = 0; d < 3; d++ ) {
          partner = rank ^ (1 << d);

          if (rank  < partner ) {
            source = rank; dest = partner;
            rc = MPI_Send(outmsg, length, MPI_CHAR, partner, tag, MPI_COMM_WORLD);
            rc = MPI_Recv(outmsg, length, MPI_CHAR, partner, tag, MPI_COMM_WORLD, &Stat);
          } else {
            source = partner; dest = rank;
            rc = MPI_Recv(outmsg, length, MPI_CHAR, partner, tag, MPI_COMM_WORLD, &Stat);
            rc = MPI_Send(outmsg, length, MPI_CHAR, partner, tag, MPI_COMM_WORLD);
          }
        }
      }
      if( rank == 0 ) {
        clock2 = MPI_Wtime(); 
        timee = (clock2-clock1) / (3*MAXITER);
        bw = (2*length)/(timee*1000000);

        printf( "Length = %6d. Elapsed time %f secs. Bandwidth = %f MBps\n", length, timee, bw );
      }
    }


    MPI_Finalize();
}


