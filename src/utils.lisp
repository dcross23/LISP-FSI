; author:
;   David Cruz García 70957692R 
;
; file: utils.lisp 
;   Recopilacion de funciones de ayuda para la implementación del algoritmo de 
;   unificación



; Devuelte True (T) si es un átomo (de LISP o una variable definida como (? x)) y NIL en 
;  caso contrario
(defun es_atomo(x)
    (cond   ((atom x) T)
            ((eq (first x) '?) T)
            (T NIL)    
    )
)

; Devuelte True (T) si es una lista del tipo (? x) (una variable definida por nosotros),
;  y NIL en caso contrario.
(defun es_variable(x)
    (cond   ((atom x) NIL)
            ((and (eq (length x) 2) (eq (first x) '?)) T)
            (T NIL)
    )
)

; Devuelte True (T) si es una lista que no es del tipo (? x) y NIL en caso contrario.
(defun es_lista(x)
    (cond   ((not (es_atomo x)) T)
            (T NIL)
    )
)

; Devuelve True (T) si la lista "lista" contiene al elto "var" y NIL en caso contrario.
(defun contiene (lista var)
    (if (and (es_lista lista) (not (eq 0 (length lista))))
        (prog (primer flag)
            (setf primer (first lista))
            (setf flag NIL)

            (if (es_atomo primer)
                (when (equal primer var) 
                    (setf flag T)
                )
                (setf flag (contiene primer var))
            )

            (when (eq flag NIL)
                (setf flag (contiene (rest lista) var))
            )

            (return flag)                 
        )  
        NIL
    )
)

