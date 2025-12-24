extends Node

'''
1. tween_property, para interpolar propiedades, eso quiere decir que podemos interpolar propiedades de cualquier tipo de nodo, como pudiera ser el color, la posición, rotación o escala.

2. tween_method, para interpolar métodos o funciones.

3. Y tween_callback, que es básicamente es una señal emitida cuando ha terminado la interpolación. Esta funcionalidad es opcional, por supuesto, pero si quisiéramos que suceda algo solo hasta que la animación haya finalizado, entonces tenemos que usar tween_callback.
'''

func _ready():
	# Encapsulo el código en funciones para mantener el control ¡Y PORQUE ESO ES UNA BUENA PRÁCTICA!
	interpolar_propiedades()
	interpolar_funcion()

func interpolar_propiedades() -> void:
	# Esto va a hacer lo siguiente: En primer lugar, creamos el tween, en segundo lugar usamos la tween_propierty para interpolar propiedades, y con tween_callback esperamos que terminen las animaciones para eliminar el nodo.
	var tween : Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT) # Se crea el Tween.
	tween.tween_property($Sprite2D, "modulate", Color.RED, 1) # Cambia a rojo el sprite.
	tween.tween_property($Sprite2D, "scale", Vector2(), 1) # Escala a 0 el sprite.
	tween.tween_callback($Sprite2D.queue_free) # Elimina el nodo.

func interpolar_funcion() -> void:
	var tween : Tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT) # Se crea el Tween.
	tween.tween_method(funcion_interpolada, 0, 10, 1).set_delay(2) # Interpola la función.
	''' tween.stop() # Con stop podemos detener una interpolación, no requiere mayor explicación. '''


func funcion_interpolada(valor : int) -> void: # Esta es la función que está interpolando ¡NO ME SEAS DESPISTADO!
	$Control/Label.text = "Contador: " + str(valor)
