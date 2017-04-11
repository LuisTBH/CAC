
#include <stdio.h>
#include <stdlib.h>
#include "omp.h"


int main(int argc, char *argv[]){

  double area, pi, x;
  int i,n, tid;
  double empieza, termina;

  
  if (argc != 2) {
    scanf("%d",&n);
//    printf ("Uso: pi n\n");
  }else{
   
    n=atoi(argv[1]);
  }

    empieza = omp_get_wtime();

    area = 0.0;
  
  #pragma omp parallel for private (x)
    for(i=0; i<n; i++) {
  	  x = (i+0.5)/n;
  #pragma omp atomic
	  area += 4.0/(1.0+x*x);	
      }
	
    pi = area/n; 
    printf ("%f\n", pi);

    termina = omp_get_wtime();
    printf("\nTiempo=%lf\n", termina-empieza);

//  }  
  return 0;
}
