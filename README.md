# homebrew-qiskit
Homebrew Tap for QISKit

## Add tap

```
brew tap indisoluble/qiskit
```

## Installation

### QASM simulator without full OpenMP parallelization

```
brew install qasm_simulator_cpp
```

### QASM simulator with OpenMP 

```
brew install qasm_simulator_cpp --with-openmp
```

**NOTICE:** In order to use this option, the simulator has to be compiled with `gcc`. If it is not already installed in your computer, it will be automatically downloaded but it is **important** that the Command Line Tools (CLT) for Xcode are installed on advance in your mac. Otherwise, at the end of the installation process, you might get a *warning* like this one: 

```
...
==> make install
Warning: indisoluble/qiskit/qasm_simulator_cpp dependency gmp was built with a different C++ standard library (libc++ from clang). This may cause problems at runtime.
...
```

To check if *CLT* are installed, run `brew config`; you should see an output like the following: 

```
...
CLT: 9.4.0.0.1.1526532315
...
```

If *CLT* is `N/A` instead, you have to install it by executing `xcode-select --install`.

## Running

```
qasm_simulator_cpp input.json
```

Or:

```
cat input.json | qasm_simulator_cpp -
```
