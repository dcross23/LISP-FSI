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

(defun test_es_atomo(elto result)
    (if (equal (es_atomo elto) result)
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

(defun test_es_variable(elto result)
    (if (equal (es_variable elto) result)
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

(defun test_es_lista(elto result)
    (if (equal (es_lista elto) result)
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

(defun test_contiene(lista elto result)
    (if (equal (contiene lista elto) result)
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

(defun test_get_sustitucion(elto lista_sust result)
    (if (equal (get_sustitucion elto lista_sust) result)
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

(defun test_aplicacion(lista_sust elto result)
    (if (equal (aplicacion lista_sust elto) result)
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

(defun test_composicion(S1 S2 result)
    (if (equal (composicion S1 S2) result)
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

(defun test_unificacion(E1 E2 result)
    (if (equal (unificacion E1 E2) result)
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

(defun imprimir_unificacion(E1 E2)
    (princ "    E1: ") (write E1) (terpri)
    (princ "    E2: ") (write E2) (terpri)
    (setf res (unificacion E1 E2))
    (princ "    Resultado: ") (write res) (terpri)

    (when (not(equal res 'FALLO))
        (princ "    E1 tras unificar: ") (write (aplicacion res E1)) (terpri)
        (princ "    E2 tras unificar: ") (write (aplicacion res E2)) (terpri)
    )
)

(write-line "------------------")
(write-line "Tests es_atomo:")
(write-line "------------------")
(princ "  ") (write (test_es_atomo 'A T)) (terpri)
(princ "  ") (write (test_es_atomo '(? a) T)) (terpri)
(princ "  ") (write (test_es_atomo '() T)) (terpri)
(princ "  ") (write (test_es_atomo '(1 2) NIL)) (terpri)
(princ "  ") (write (test_es_atomo '(A (? b)) NIL)) (terpri)
(write-line "")


(write-line "------------------")
(write-line "Tests es_variable:")
(write-line "------------------")
(princ "  ") (write (test_es_variable 'A NIL))  (terpri)
(princ "  ") (write (test_es_variable '(? a) T))  (terpri)
(princ "  ") (write (test_es_variable '() NIL))  (terpri)
(princ "  ") (write (test_es_variable '(1 2) NIL))  (terpri)
(princ "  ") (write (test_es_variable '(A (? b)) NIL))  (terpri)
(write-line "")


(write-line "------------------")
(write-line "Tests es_lista:")
(write-line "------------------")
(princ "  ") (write (test_es_lista 'A NIL))  (terpri)
(princ "  ") (write (test_es_lista '(? A) NIL))  (terpri)
(princ "  ") (write (test_es_lista '() NIL))  (terpri)
(princ "  ") (write (test_es_lista '(1 2) T))  (terpri)
(princ "  ") (write (test_es_lista '(A (? b)) T))  (terpri)
(write-line "")


(write-line "------------------")
(write-line "Tests contiene:")
(write-line "------------------")
(princ "  ") (write (test_contiene '(1 2 3) '1 T))  (terpri)
(princ "  ") (write (test_contiene '(A (? b)) '(? c) NIL))  (terpri)
(princ "  ") (write (test_contiene '(A (? b)) '(? b) T))  (terpri)
(princ "  ") (write (test_contiene '((1 2) (A (? x)) 3) '(? x) T))  (terpri)
(princ "  ") (write (test_contiene '((1 5) (4 (1 (9 2))) 3) '2 T))  (terpri)
(write-line "")


(write-line "------------------")
(write-line "Tests get_sustitucion:")
(write-line "------------------")
(princ "  ") (write (test_get_sustitucion '(? x) '((A (? x)) (B (? y))) 'A)) (terpri)
(princ "  ") (write (test_get_sustitucion '(f (? x) (? y)) '((A (? x)) (W (f (? x) (? y)))) 'W)) (terpri)
(princ "  ") (write (test_get_sustitucion '((? x) (? y)) '((A (? x)) (W (? y))) '((? x) (? y)))) (terpri)
(write-line "")


(write-line "------------------")
(write-line "Tests aplicacion:")
(write-line "------------------")
(setf lsust '((A (? x)) (B (? y)) (C (? w)) (D (? z))) )
(setf elto '((g (? x) (? y)) (? z)) )
(setf result '((G A B) D))
(princ "  ") (write (test_aplicacion lsust elto result )) (terpri)

(setf lsust '((A (? x)) (B (? y)) (C (? w)) (D (? z))) )
(setf elto '((f (? x)) (? x) (g (? y)) (? w)) )
(setf result '((f A) A (g B) C))
(princ "  ") (write (test_aplicacion lsust elto result )) (terpri)

(setf lsust '((A (? x)) (B (? y)) (C (? w)) (D (? z))) )
(setf elto '((f (g (? y) (? x))) (? x) (g (? w)) (? r)) )
(setf result '((f (g B A)) A (g C) (? r)) )
(princ "  ") (write (test_aplicacion lsust elto result )) (terpri)
(write-line "")


(write-line "------------------")
(write-line "Tests composicion:")
(write-line "------------------")
(setf S1 '(((g (? x) (? y)) (? z))) )
(setf S2 '((A (? x)) (B (? y)) (C (? w)) (D (? z))) )
(setf result '(((g A B) (? z)) (A (? x)) (B (? y)) (C (? w))) )
(princ "  ") (write (test_composicion S1 S2 result )) (terpri)

(setf S1 '( ((f (? x)) (? x)) ((g (? y)) (? w)) ) )
(setf S2 '((A (? x)) (B (? y)) (C (? w)) (D (? z))) )
(setf result '( ((f A) (? x)) ((g B) (? w)) (B (? y)) (D (? z)) ) )
(princ "  ") (write (test_composicion S1 S2 result )) (terpri)

(setf S1 '(((f (g (? y) (? x))) (? w))  ((g (? z)) (? z))) )
(setf S2 '((A (? x)) (B (? y)) (C (? w)) (D (? z))) )
(setf result '( ((f (g B A)) (? w)) ((g D) (? z)) (A (? x)) (B (? y))) )
(princ "  ") (write (test_composicion S1 S2 result )) (terpri)
(write-line "")


(write-line "------------------")
(write-line "Tests unificacion:")
(write-line "------------------")
(setf E1 '(P (? z) (F (? x))) )
(setf E2 '(P A (? y)) )
(setf result '((A (? z)) ((F (? x)) (? y))) )
(imprimir_unificacion E1 E2)
(princ " ") (write (test_unificacion E1 E2 result )) (terpri) (terpri)

(setf E1 '(F (? x) (G (? x))) )
(setf E2 '(F A (? z)) )
(setf result '( (A (? x)) ((G A) (? z)) ) )
(imprimir_unificacion E1 E2)
(princ " ") (write (test_unificacion E1 E2 result )) (terpri) (terpri)

(setf E1 '(P (? x) (F (? x))) ) 
(setf E2 '(P A C D) )
(setf result 'FALLO )
(imprimir_unificacion E1 E2)
(princ " ") (write (test_unificacion E1 E2 result )) (terpri) (terpri)

(setf E1 '(P (? x) (F A)) )
(setf E2 '(P (g B) (? y)) )
(setf result '( ((g B) (? x)) ((f A) (? y)) ) )
(imprimir_unificacion E1 E2)
(princ " ") (write (test_unificacion E1 E2 result )) (terpri) (terpri)

(setf E1 '(P (? x) (? w) (F (? w)) (F A)) )
(setf E2 '(P (g B) C (F C) (? y)) )
(setf result '( ((g B) (? x)) (C (? w)) ((f A) (? y)) ) )
(imprimir_unificacion E1 E2)
(princ " ") (write (test_unificacion E1 E2 result )) (terpri) (terpri)

(setf E1 '(P (? x) (? w) (F (? w)) (F A)) )
(setf E2 '(P (g B) C (F C A) (? y)) )
(setf result 'FALLO )
(imprimir_unificacion E1 E2)
(princ " ") (write (test_unificacion E1 E2 result )) (terpri) (terpri)
(write-line "")

(write-line "------------------")
(write-line "RESULTADOS")
(write-line "------------------")
(princ "TOTAL:        ") (write total_tests) (terpri)
(princ "Tests passed: ") (write passed_tests) (terpri)
(princ "Tests failed: ") (write failed_tests) (terpri)


