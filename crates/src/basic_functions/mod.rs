pub mod basic_math;
pub mod basic_strings;

use pyo3::prelude::*;

#[pymodule]
pub fn basic_functions(m: &Bound<'_, PyModule>) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(basic_math::add_in_rust, m)?)?;
    m.add_function(wrap_pyfunction!(basic_math::subtract_in_rust, m)?)?;
    m.add_function(wrap_pyfunction!(basic_strings::concat_in_rust, m)?)?;
    Ok(())
}
