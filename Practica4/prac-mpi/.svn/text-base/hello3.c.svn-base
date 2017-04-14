#include "mpi.h"
#include <stdio.h>

int main( int argc, char *argv[] )
{
    int idproc, numprocs, namelen, i;
    char proc_name[MPI_MAX_PROCESSOR_NAME];
    char greeting[MPI_MAX_PROCESSOR_NAME+80];
    MPI_Status status;
    
    MPI_Init (&argc, &argv );
    MPI_Comm_rank ( MPI_COMM_WORLD, &idproc );
    MPI_Comm_size ( MPI_COMM_WORLD, &numprocs );
    MPI_Get_processor_name (proc_name, &namelen );
    
    sprintf(greeting, "Hello world from process %d of %d on %s",
            idproc, numprocs, proc_name);
    
    if (idproc == 0) {
       printf("%s\n",greeting);
       for (i=1; i<numprocs; i++) {
         MPI_Recv(greeting, sizeof( greeting ), MPI_CHAR,
	          i, 1, MPI_COMM_WORLD, &status );
         printf("%s\n", greeting );
       }	    
    }
    else {
      MPI_Send(	greeting, strlen( greeting ) + 1, MPI_CHAR,
                0, 1, MPI_COMM_WORLD );
    }
           
    MPI_Finalize();
    return 0;
}
