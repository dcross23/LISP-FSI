; author:
;   David Cruz García 70957692R 
;
; file: sustitucion.lisp 
;   Algoritmo para la sustitucion de variables (aplicacion y composicion)

(load "utils.lisp")

; Busca una sustitucion válida para el elemento "elto" en la lista de sustituciones "sustituciones". Si no lo encuentra
;  en toda la lista, devuelve el propio elemento.
(defun get_sustitucion (elto sustituciones)
    'FALLO
)

; Aplica las susticiones de la lista "sustiticiones" al elemento "elto"
; - Si el elto a sustituir es una lista, hay que buscar recursivamente que eltos que hay dentro de dicha lista
; - Si el elto es una variable, se busca una sustitución válida para dicha variable
; - Si el elto no es ni lista ni variable, se devuelvo el propio elto porque no hay que sustituirlo
(defun aplicacion (sustituciones elto)
    'FALLO
)
 

; Compone S1 con S2 para crear S1S2
(defun composicion(S1 S2)
    'FALLO
)