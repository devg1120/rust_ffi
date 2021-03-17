 gcc -shared a.c -o liba.so -fPIC
 gcc main.c  -o test1.exe -L. -la
 export LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH 
 test1.exe
