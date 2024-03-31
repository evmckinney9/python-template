//src/lib.rs

pub mod basic_functions;
use crate::basic_functions::*;

use pyo3::prelude::*;

#[pymodule]
fn quippers(_py: Python, m: &PyModule) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(basic_string::concat_in_rust, m)?)?;
    m.add_function(wrap_pyfunction!(basic_math::add_in_rust, m)?)?;
    m.add_function(wrap_pyfunction!(basic_math::subtract_in_rust, m)?)?;

    Ok(())
}
