CC=/opt/gnu/arm/bin/arm-eabi-gcc
AS=/opt/gnu/arm/bin/arm-eabi-gcc

CFLAGS=-Wall -gdwarf-2

all: essai-map essai-red

clean:
	/bin/rm -rf *.o image_bits_include.h image_bits_content.c

map.o:	map.s
	${CC} ${CFLAGS} -c $< -o $@

es.o:	es.s
	${CC} ${CFLAGS} -c $< -o $@

gestion_tab.o:	gestion_tab.s
	${CC} ${CFLAGS} -c $< -o $@

fg.o:	fg.s
	${CC} ${CFLAGS} -c $< -o $@

essai-map.o: essai-map.s
	${CC} ${CFLAGS} -c $< -o $@

red.o: red.s
	${CC} ${CFLAGS} -c $< -o $@

essai-red.o: essai-red.s
	${CC} ${CFLAGS} -c $< -o $@

essai-map: essai-map.o map.o es.o gestion_tab.o fg.o
	${CC} ${CFLAGS} -o $@ $^

essai-red: essai-red.o red.o es.o gestion_tab.o fg.o
	${CC} ${CFLAGS} -o $@ $^

