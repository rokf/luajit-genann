all:
	gcc -c -fPIC genann/genann.c -o genann.o
	gcc -shared  -o libgenann.so genann.o
clean:
	rm -f *.o
	rm -f *.so
install:
	cp libgenann.so /usr/local/lib/libgenann.so
uninstall:
	rm /usr/local/lib/libgenann.so
