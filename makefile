VER=1.0
DIST=tesa$(VER)
PROGS=tesa
SRCS=struct.c compare_sequence.c make_graph.c get_options.c fib.c write_file.c find_clique.c main.c closure_process.c pvalue.c read_file.c matrix_process.c 
OBJS=$(SRCS:.c=.o) 
CC=gcc -g


LDFLAGS= -static  -lm 
CFLAGS=-g -O3 -Wall -ansi -I.  -D VER=$(VER) 


all: $(PROGS)

tesa: $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)
.o:
	$(CC) $(CFLAGS) $< -o $@ 

clean:
	rm -f $(PROGS)
	rm -f *.o
	rm -f *.closures

dist:
	$(MAKE) clean
	cd .. && tar czvf $(DIST).tar.gz $(DIST)/
test:
	$(MAKE)
	./tesa.exe -i test.fasta -l 14 -F
testP:
	$(MAKE)
	./tesa -i example -P
testM:
	$(MAKE)
	./tesa -i example -M
testG:
	$(MAKE)
	./tesa -i example -G
testC:
	$(MAKE)
	./tesa -i example -C
testa:
	$(MAKE)
	./tesa -i example -j example_anno 
