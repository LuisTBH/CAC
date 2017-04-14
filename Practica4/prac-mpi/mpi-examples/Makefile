##### User configurable options #####

CC          = mpicc
CLINKER     = mpicc
CCC         = mpiCC
CCLINKER    = $(CCC)
MPIFDEP     = 
MAKE        = make --no-print-directory

### End User configurable options ###

SHELL = /bin/sh

PROFLIB =
CFLAGS  = -I/usr/include/lam
CCFLAGS = $(CFLAGS)
LFLAGS = -L/usr/lib/lam
# Use LIBS to add any special libraries for C programs
LIBS = -lmpi
EXECS = ping-pong pairs nonblock scatter reduce allreduce group derived grid

default: $(EXECS)

ping-pong: ping-pong.o
	$(CLINKER) $(LFLAGS) -o ping-pong ping-pong.o $(LIBS)
pairs: pairs.o 
	$(CLINKER) $(LFLAGS) -o pairs pairs.o $(LIBS) 
nonblock: nonblock.o 
	$(CLINKER) $(LFLAGS) -o nonblock nonblock.o $(LIBS) 
scatter: scatter.o
	$(CLINKER) $(LFLAGS) -o scatter scatter.o $(LIBS) 
reduce: reduce.o 
	$(CLINKER) $(LFLAGS) -o reduce reduce.o $(LIBS) 
allreduce: allreduce.o 
	$(CLINKER) $(LFLAGS) -o allreduce allreduce.o $(LIBS) 
group: group.o 
	$(CLINKER) $(LFLAGS) -o group group.o $(LIBS) 
derived: derived.o
	$(CLINKER) $(LFLAGS) -o derived derived.o $(LIBS)
grid: grid.o 
	$(CLINKER) $(LFLAGS) -o grid grid.o $(LIBS) 

clean:
	@-/bin/rm -f *.o *~ PI* $(EXECS) core *.out coll.diff *.trace

.c.o:
	$(CC) $(CFLAGS) -c $*.c
