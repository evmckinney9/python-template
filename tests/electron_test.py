from src.sample.main import Electron

def test_electron():
    """Test the Electron class."""
    electron = Electron()
    assert electron.charge == -1
    assert electron.mass == 2.1
    assert electron.really_long_named_attribute_that_probably_does_not_fit_nicely == 2.1
    assert electron.compute_momentum(2.1) == 4.42