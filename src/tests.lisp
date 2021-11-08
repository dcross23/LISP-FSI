; author:
;   David Cruz García 70957692R 
;
; file: tests.lisp 
;   Recopilacion de tests para la prueba de las distintas funciones durante su desarrollo

(load "utils.lisp")
(load "sustitucion.lisp")
(load "unificacion.lisp")

(setf passed_tests 0)
(setf failed_tests 0)
(setf total_tests 0)

(defun test_func (func_result result)
    (if (equal func_result result)
        (progn
            (setf passed_tests (1+ passed_tests))
            (setf total_tests (1+ total_tests))
            'PASSED
        )
        (progn
            (setf failed_tests (1+ failed_tests))
            (setf total_tests (1+ total_tests))
            'FAILED
        )
    )
)

(defun imprimir_unificacion(E1 E2 func_res)
    (princ "    E1: ") (write E1) (terpri)
    (princ "    E2: ") (write E2) (terpri)
    (princ "    Resultado: ") (write func_res) (terpri)

    (when (not(equal func_res 'FALLO))
        (princ "    E1 tras unificar: ") (write (aplicacion func_res E1)) (terpri)
        (princ "    E2 tras unificar: ") (write (aplicacion func_res E2)) (terpri)
    )
)

(write-line "------------------")
(write-line "Tests es_atomo:")
(write-line "------------------")
(princ "  ") (write (test_func (es_atomo 'A) T)) (terpri)
(princ "  ") (write (test_func (es_atomo '(? a)) T)) (terpri)
(princ "  ") (write (test_func (es_atomo '()) T)) (terpri)
(princ "  ") (write (test_func (es_atomo '(1 2)) NIL)) (terpri)
(princ "  ") (write (test_func (es_atomo '(A (? b))) NIL)) (terpri)
(write-line "")


(write-line "------------------")
(write-line "Tests es_variable:")
(write-line "------------------")
(princ "  ") (write (test_func (es_variable 'A) NIL))  (terpri)
(princ "  ") (write (test_func (es_variable '(? a)) T))  (terpri)
(princ "  ") (write (test_func (es_variable '()) NIL))  (terpri)
(princ "  ") (write (test_func (es_variable '(1 2)) NIL))  (terpri)
(princ "  ") (write (test_func (es_variable '(A (? b))) NIL))  (terpri)
(write-line "")


(write-line "------------------")
(write-line "Tests es_lista:")
(write-line "------------------")
(princ "  ") (write (test_func (es_lista 'A) NIL))  (terpri)
(princ "  ") (write (test_func (es_lista '(? A)) NIL))  (terpri)
(princ "  ") (write (test_func (es_lista '()) NIL))  (terpri)
(princ "  ") (write (test_func (es_lista '(1 2)) T))  (terpri)
(princ "  ") (write (test_func (es_lista '(A (? b))) T))  (terpri)
(write-line "")


(write-line "------------------")
(write-line "Tests contiene:")
(write-line "------------------")
(princ "  ") (write (test_func (contiene '(1 2 3) '1) T))  (terpri)
(princ "  ") (write (test_func (contiene '(A (? b)) '(? c)) NIL))  (terpri)
(princ "  ") (write (test_func (contiene '(A (? b)) '(? b)) T))  (terpri)
(princ "  ") (write (test_func (contiene '((1 2) (A (? x)) 3) '(? x)) T))  (terpri)
(princ "  ") (write (test_func (contiene '((1 5) (4 (1 (9 2))) 3) '2) T))  (terpri)
(write-line "")


(write-line "------------------")
(write-line "Tests get_sustitucion:")
(write-line "------------------")
(setf sustituciones '((A (? x)) (B (? y))) )
(princ "  ") (write (test_func (get_sustitucion '(? x) sustituciones sustituciones) 'A)) (terpri)

(setf sustituciones '((A (? x)) (W (f (? x) (? y)))) )
(princ "  ") (write (test_func (get_sustitucion '(f (? x) (? y)) sustituciones sustituciones) 'W)) (terpri)

(setf sustituciones '((A (? x)) (W (? y))) )
(princ "  ") (write (test_func (get_sustitucion '((? x) (? y)) sustituciones sustituciones) '((? x) (? y)))) (terpri)
(write-line "")


(write-line "------------------")
(write-line "Tests aplicacion:")
(write-line "------------------")
(setf lsust '((A (? x)) (B (? y)) (C (? w)) (D (? z))) )
(setf elto '((g (? x) (? y)) (? z)) )
(setf result '((G A B) D))
(princ "  ") (write (test_func (aplicacion lsust elto) result )) (terpri)

(setf lsust '((A (? x)) (B (? y)) (C (? w)) (D (? z))) )
(setf elto '((f (? x)) (? x) (g (? y)) (? w)) )
(setf result '((f A) A (g B) C))
(princ "  ") (write (test_func (aplicacion lsust elto) result )) (terpri)

(setf lsust '((A (? x)) (B (? y)) (C (? w)) (D (? z))) )
(setf elto '((f (g (? y) (? x))) (? x) (g (? w)) (? r)) )
(setf result '((f (g B A)) A (g C) (? r)) )
(princ "  ") (write (test_func (aplicacion lsust elto) result )) (terpri)

(setf lsust '( ((? x) (? y)) ))
(setf elto   '((f (g (? y) (? x))) (? y)))
(setf result '((f (g (? x) (? x))) (? x)))
(princ "  ") (write (test_func (aplicacion lsust elto) result )) (terpri)

(setf lsust '(((? x) (? y)) (A (? x)) ) )
(setf elto   '((f (g (? y) (? x))) (? x)))
(setf result '((f (g A A)) A))
(princ "  ") (write (test_func (aplicacion lsust elto) result )) (terpri)

(setf lsust '(((? x) (? y)) (A (? z)) ((? z) (? x))) )
(setf elto   '((f (g (? y) (? x))) (? z)))
(setf result '((f (g A A)) A))
(princ "  ") (write (test_func (aplicacion lsust elto) result )) (terpri)
(write-line "")


(write-line "------------------")
(write-line "Tests composicion:")
(write-line "------------------")
(setf S1 '(((g (? x) (? y)) (? z))) )
(setf S2 '((A (? x)) (B (? y)) (C (? w)) (D (? z))) )
(setf result '(((g A B) (? z)) (A (? x)) (B (? y)) (C (? w))) )
(princ "  ") (write (test_func (composicion S1 S2) result )) (terpri)

(setf S1 '( ((f (? x)) (? x)) ((g (? y)) (? w)) ) )
(setf S2 '((A (? x)) (B (? y)) (C (? w)) (D (? z))) )
(setf result '( ((f A) (? x)) ((g B) (? w)) (B (? y)) (D (? z)) ) )
(princ "  ") (write (test_func (composicion S1 S2) result )) (terpri)

(setf S1 '(((f (g (? y) (? x))) (? w))  ((g (? z)) (? z))) )
(setf S2 '((A (? x)) (B (? y)) (C (? w)) (D (? z))) )
(setf result '( ((f (g B A)) (? w)) ((g D) (? z)) (A (? x)) (B (? y))) )
(princ "  ") (write (test_func (composicion S1 S2) result )) (terpri)
(write-line "")


(write-line "------------------")
(write-line "Tests unificacion:")
(write-line "------------------")
(setf E1 '(P (? z) (F (? x))) )
(setf E2 '(P A (? y)) )
(setf result '((A (? z)) ((F (? x)) (? y))) )
(setf func_res (unificacion E1 E2))
(imprimir_unificacion E1 E2 func_res)
(princ " ") (write (test_func func_res result )) (terpri) (terpri)


(setf E1 '(F (? x) (G (? x))) )
(setf E2 '(F A (? z)) )
(setf result '( (A (? x)) ((G A) (? z)) ) )
(setf func_res (unificacion E1 E2))
(imprimir_unificacion E1 E2 func_res)
(princ " ") (write (test_func func_res result )) (terpri) (terpri)


(setf E1 '(P (? x) (F (? x))) ) 
(setf E2 '(P A C D) )
(setf result 'FALLO )
(setf func_res (unificacion E1 E2))
(imprimir_unificacion E1 E2 func_res)
(princ " ") (write (test_func func_res result )) (terpri) (terpri)


(setf E1 '(P (? x) (F A)) )
(setf E2 '(P (g B) (? y)) )
(setf result '( ((g B) (? x)) ((f A) (? y)) ) )
(setf func_res (unificacion E1 E2))
(imprimir_unificacion E1 E2 func_res)
(princ " ") (write (test_func func_res result )) (terpri) (terpri)


(setf E1 '(P (? x) (? w) (F (? w)) (F A)) )
(setf E2 '(P (g B) C (F C) (? y)) )
(setf result '( ((g B) (? x)) (C (? w)) ((f A) (? y)) ) )
(setf func_res (unificacion E1 E2))
(imprimir_unificacion E1 E2 func_res)
(princ " ") (write (test_func func_res result )) (terpri) (terpri)


(setf E1 '(P (? x) (? w) (F (? w)) (F A)) )
(setf E2 '(P (g B) C (F C A) (? y)) )
(setf result 'FALLO )
(setf func_res (unificacion E1 E2))
(imprimir_unificacion E1 E2 func_res)
(princ " ") (write (test_func func_res result )) (terpri) (terpri)
(write-line "")



(write-line "------------------")
(write-line "RESULTADOS")
(write-line "------------------")
(princ "TOTAL:        ") (write total_tests) (terpri)
(princ "Tests passed: ") (write passed_tests) (terpri)
(princ "Tests failed: ") (write failed_tests) (terpri)


