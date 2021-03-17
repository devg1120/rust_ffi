 gcc -shared a.c -o liba.so -fPIC
 nm liba.so
 rustc -o test_rs.exe main.rs -L. -la
 export LD_LIBRARY_PATH=.:$LD_LIBRARY_PATH
 test_rs.exe
