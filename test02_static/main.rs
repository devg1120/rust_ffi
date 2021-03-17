extern "C" {
    fn func_a();
}

fn main() {
    unsafe {
        func_a();
    }
}
