# homebrew-qiskit
Homebrew Tap for QISKit

## Installation

```
brew tap indisoluble/qiskit
```

### QASM simulator without full OpenMP parallelization

```
brew install qasm_simulator_cpp
```

### QASM simulator with OpenMP
**NOTICE: Requires GCC. It will be automatically installed if necessary** 

```
brew install qasm_simulator_cpp --with-openmp
```

## Running

```
qasm_simulator_cpp input.json
```

Or:

```
cat input.json | qasm_simulator_cpp -
```
