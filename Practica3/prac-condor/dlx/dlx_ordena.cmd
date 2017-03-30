universe = vanilla
executable = dlx
log = dlx_ordena.log

arguments = -s final -d p -c p -f ordena.s
output = dlx_ordena.$(Process).out
error = dlx_ordena.$(Process).error
queue

arguments = -s final -d c -c p -f ordena.s
output = dlx_ordena.$(Process).out
error = dlx_ordena.$(Process).error
queue

arguments = -s final -d p -c t -f ordena.s
output = dlx_ordena.$(Process).out
error = dlx_ordena.$(Process).error
queue

arguments = -s final -d c -c t -f ordena.s
output = dlx_ordena.$(Process).out
error = dlx_ordena.$(Process).error
queue

arguments = -s final -d p -c 3 -f ordena3.s
output = dlx_ordena3.$(Process).out
error = dlx_ordena3.$(Process).error
queue

arguments = -s final -d c -c 3 -f ordena3.s
output = dlx_ordena3.$(Process).out
error = dlx_ordena3.$(Process).error
queue

arguments = -s final -d c -c 2 -f ordena3.s
output = dlx_ordena3.$(Process).out
error = dlx_ordena3.$(Process).error
queue

arguments = -s final -d c -c 1 -f ordena3.s
output = dlx_ordena3.$(Process).out
error = dlx_ordena3.$(Process).error
queue




