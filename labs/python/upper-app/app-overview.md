# Python Upper App Overview

## Introduction

The **Python Upper App** is a utility that takes user-provided arguments, converts them to uppercase, and either displays them in the terminal or processes them programmatically. This project demonstrates Python fundamentals such as string manipulation, testing, and packaging. The source code is located under the `src/python/upper_project` directory.

---

## Key Components

### 1. **Core Functionality**: `upper.py`

The `upper.py` script contains the main logic for converting strings to uppercase. It includes:

- The `to_upper` function for string manipulation.
- Command-line integration for direct execution.

#### **Source Code**: `upper.py`

```python
def to_upper(*args):
    """
    Converts the given arguments to uppercase.

    Args:
        *args: Variable-length arguments representing strings to convert.

    Returns:
        str: A single string of all arguments converted to uppercase and joined with spaces.
    """
    return ' '.join(arg.upper() for arg in args)

if __name__ == "__main__":
    import sys
    args = sys.argv[1:]  # Get arguments from the command line
    print(to_upper(*args))  # Print the uppercase conversion
```

#### **Usage**:

1. Run the script from the terminal:

   ```bash
   python upper.py hello world
   ```

   **Output**:

   ```bash
   HELLO WORLD
   ```

---

### 2. **Unit Testing**: `test_upper.py`

This module tests the `to_upper` function using the Python `unittest` framework. It ensures that the app behaves as expected for various inputs.

#### **Source Code**: `test_upper.py`

```python
import unittest
from upper.upper import to_upper

class TestUpperModule(unittest.TestCase):

    def test_single_character(self):
        self.assertEqual(to_upper("a"), "A")

    def test_single_word(self):
        self.assertEqual(to_upper("hello"), "HELLO")

    def test_multiple_words(self):
        self.assertEqual(to_upper("hello", "world"), "HELLO WORLD")

    def test_mixed_case(self):
        self.assertEqual(to_upper("Hello", "World"), "HELLO WORLD")

    def test_empty_input(self):
        self.assertEqual(to_upper(), "")

    def test_numbers_and_special_chars(self):
        self.assertEqual(to_upper("123", "@#$"), "123 @#$")

if __name__ == '__main__':
    unittest.main()
```

#### **Running Tests**:

Run the tests using:

```bash
python -m unittest discover -s src/python/upper_project -p "test_*.py"
```

---

### 3. **Packaging**: `setup.py`

The project is packaged for distribution using Python's `setuptools`. This allows the app to be installed and used as a command-line utility.

#### **Source Code**: `setup.py`

```python
from setuptools import setup, find_packages

setup(
    name="upper_project",  # Name of your package
    version="0.1",  # Version of your package
    description="A Python module to convert user provided arguments to uppercase.",  # Short description
    author="Prasad Honrao",
    author_email="honrao.prasad@gmail.com",
    packages=find_packages(),  # Automatically discover all packages and subpackages
    install_requires=[],  # List of dependencies (leave empty if there are none)
    entry_points={
        'console_scripts': [
            'upper=upper.upper:to_upper',  # Command line utility setup
        ]
    },
    classifiers=[
        "Programming Language :: Python :: 3",  # Specify compatible Python versions
        "License :: OSI Approved :: MIT License",  # License type
        "Operating System :: OS Independent",  # OS compatibility
    ],
    python_requires='>=3.6',  # Minimum Python version
)
```

#### **Install and Use as CLI Tool**:

1. Install the project:

   ```bash
   pip install .
   ```

2. Use the `upper` command-line tool:

   ```bash
   upper hello world
   ```

   **Output**:

   ```bash
   HELLO WORLD
   ```

---

## Directory Structure

```bash
src/
└── python/
    └── upper_project/
        ├── upper/
        │   ├── __init__.py
        │   ├── upper.py
        ├── tests/
        │   ├── test_upper.py
        ├── setup.py
```

---

## Features

1. **String Manipulation**:

   - Converts strings to uppercase.
   - Handles multiple inputs and combines them.

2. **Command-Line Interface**:

   - Provides a utility for quick string conversions directly from the terminal.

3. **Unit Testing**:

   - Ensures robust functionality through comprehensive test cases.

4. **Packaging**:
   - Enables distribution and installation using Python packaging tools.

---

## Summary

The **Python Upper App** is a simple yet versatile utility to demonstrate Python's string processing, testing, and packaging capabilities. It can be extended for additional functionality, such as more advanced text processing or integration into larger systems.
