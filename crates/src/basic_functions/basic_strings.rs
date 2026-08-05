use pyo3::prelude::*;

#[pyfunction]
pub fn concat_in_rust(a: String, b: String) -> String {
    a + &b
}
