 gcc -c a.c 
 ar crs liba.a a.o
 gcc main.c  -o test1.exe -L. -la
 test1.exe
