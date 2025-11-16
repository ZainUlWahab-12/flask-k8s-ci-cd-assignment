# tests/test_calculator.py
from ..mypackage.calculator import add


def test_add_positive_numbers():
    assert add(2, 3) == 5


def test_add_zero():
    assert add(0, 0) == 0
