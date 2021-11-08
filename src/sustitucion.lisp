; author:
;   David Cruz García 70957692R 
;
; file: sustitucion.lisp 
;   Algoritmo para la sustitucion de variables (aplicacion y composicion)

(load "utils.lisp")

; Busca una sustitucion válida para el elemento "elto" en la lista de sustituciones "sustituciones". Si no lo encuentra
;  en toda la lista, devuelve el propio elemento. En caso de encontrar una sustitucion del tipo "variable/variable", busca
;  a ver si la nueva variable tambien tiene una sustitución posible
(defun get_sustitucion (elto sustituciones todas_sustituciones)
    (cond ((eq 0 (length sustituciones)) elto)
        ((equal elto (second (first sustituciones))) 
        	(if (es_variable (first (first sustituciones)))
        		(get_sustitucion (first (first sustituciones)) todas_sustituciones todas_sustituciones) 
        		(first (first sustituciones))
        	)           
        )
        (T (get_sustitucion elto (rest sustituciones) todas_sustituciones))
    )
)

; Aplica las susticiones de la lista "sustiticiones" al elemento "elto"
; - Si el elto a sustituir es una lista, hay que buscar recursivamente que eltos que hay dentro de dicha lista
; - Si el elto es una variable, se busca una sustitución válida para dicha variable
; - Si el elto no es ni lista ni variable, se devuelvo el propio elto porque no hay que sustituirlo
(defun aplicacion (sustituciones elto)
    (prog (resultado)
        (cond   ((es_lista elto)
                    (progn ()
                        (loop for x in elto do
                            (cond ((not (es_atomo x)) (setf resultado (append resultado (list (aplicacion sustituciones x)))))
                                  ((es_variable x)    (setf resultado (append resultado (list (get_sustitucion x sustituciones sustituciones)))))
                                  (T                  (setf resultado (append resultado (list x))))
                            )  
                        )
                    )
                )

                ((es_variable elto) (setf resultado (append resultado (get_sustitucion elto sustituciones sustituciones))))
                (T (setf resultado (append resultado elto)))            
        )
        (return resultado)
    ) 
)
 

; Compone S1 con S2 para crear S1S2
(defun composicion(S1 S2)
    (setf S1S2 '())   
    
    ; Aplicar S2 a S1 
    (loop for regla in S1 do
        (setf sustituido  (aplicacion S2 (first regla)))
        (setf sustitucion (second regla))
        (setf S1S2 (append S1S2 (list (list sustituido sustitucion))))
    )

    ; Añadir a la lista las reglas de S2 que no tengan la misma sustitucion que alguna
    ;   de las reglas que hay en S1S2
    (loop for regla in S2 do
        (setf flag NIL)
        (loop for regla2 in S1S2 do
            (when (equal (second regla) (second regla2))
                (setf flag T)
            )
        )
        (when (eq flag NIL)
            (setf S1S2 (append S1S2 (list regla)))
        )
    )

    S1S2
)
