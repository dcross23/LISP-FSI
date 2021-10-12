# LISP-FSI
Collection of LISP programs for "Fundamentos de Sistemas Inteligentes (4º), USAL"

## Usage
- To run unification algorithm, create a **.lisp** file and load **unificacion.lisp** file. 
  For example **example.lisp**:
```lisp
    ; create example.lisp and add this
    (load "unificacion.lisp")
    (write (unificacion E1 E2)) 
```
  Now run **example.lisp**:
```console
$ clisp example.lisp
```

- To run tests, just run:
```console
$ clisp tests.lisp
```
