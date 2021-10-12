; author:
;   David Cruz García 70957692R 
;
; file: unificacion.lisp 
;   Algoritmo de unificación

(load "utils.lisp")
(load "sustitucion.lisp")

(defun unificar_con_atomo (E1 E2)
    (cond   ((equal E1 E2) '())
            ((es_variable E1)   (if (contiene E2 E1)
                                    'FALLO
                                    (list (list E2 E1))
                                )
            )
            ((es_variable E2) (list (list E1 E2)))
            (T 'FALLO)
    )    
)

(defun unificar_sin_atomo (E1 E2)
    (prog (F1 T1 F2 T2 Z1 G1 Z2 G2)
        (setf F1 (first E1)) (setf T1 (rest E1))
        (setf F2 (first E2)) (setf T2 (rest E2))
        
        (setf Z1 (unificacion F1 F2))
        (if (equal Z1 'FALLO)
            (setf ret 'FALLO)   
            (progn
                (setf G1 (aplicacion Z1 T1))
                (setf G2 (aplicacion Z1 T2))  

                (setf Z2 (unificacion G1 G2))
                (if (equal Z2 'FALLO)
                    (setf ret 'FALLO) 
                    (setf ret (composicion Z1 Z2))
                )
            )   
        )

        (return ret)
    )
)

(defun unificacion (E1 E2)
    (cond   ((es_atomo E1) (unificar_con_atomo E1 E2))
            ((es_atomo E2) (unificar_con_atomo E2 E1))
            (T             (unificar_sin_atomo E1 E2))
    )
)
