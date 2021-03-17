 gcc -c a.c  -fPIC
 ar crs liba.a a.o
 rustc -o test_rs.exe main.rs -L. -la
 test_rs.exe
