use pyo3::prelude::*;

#[pyfunction]
pub fn add_in_rust(a: i32, b: i32) -> i32 {
    a + b
}

#[pyfunction]
pub fn subtract_in_rust(a: i32, b: i32) -> i32 {
    a - b
}
