#include <mpi.h>
#include <stdio.h>

int main( int argc, char *argv[] ) 
{
    int numtasks, rank, dest, source, rc, tag=1;  
    char inmsg, outmsg='x';
    MPI_Status Stat;

    MPI_Init(&argc,&argv);
    MPI_Comm_size(MPI_COMM_WORLD, &numtasks);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);

    if (rank == 0) {
      dest = 1;
      source = 1;
      rc = MPI_Send(&outmsg, 1, MPI_CHAR, dest, tag, MPI_COMM_WORLD);
      rc = MPI_Recv(&inmsg, 1, MPI_CHAR, source, tag, MPI_COMM_WORLD, &Stat);
      printf( "Processor 0: msg=%c from processor 1\n", inmsg );
    } else if (rank == 1) {
      dest = 0;
      source = 0;
      rc = MPI_Recv(&inmsg, 1, MPI_CHAR, source, tag, MPI_COMM_WORLD, &Stat);
      rc = MPI_Send(&outmsg, 1, MPI_CHAR, dest, tag, MPI_COMM_WORLD);
      printf( "Processor 1: msg=%c from processor 0\n", inmsg );
    }

    MPI_Finalize();
}


