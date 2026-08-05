use pyo3::prelude::*;
use pyo3::wrap_pymodule;

mod basic_functions;

#[pymodule]
fn _accelerate(m: &Bound<'_, PyModule>) -> PyResult<()> {
    m.add_wrapped(wrap_pymodule!(basic_functions::basic_functions))?;
    Ok(())
}
