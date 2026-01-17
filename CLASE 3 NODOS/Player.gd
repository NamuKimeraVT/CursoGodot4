extends CharacterBody2D
class_name Player

# Variables
var death : bool = false

var can_attack = true

@export_category("⚙️ Config")
@export_group("Required References")
@export var gui: CanvasLayer

@export_group("Motion")
@export var speed = 100 # Velocidad de movimiento
@export var health = 100 # Salud
@export var jump = 160 # Salto
@export var gravity = 10 # Gravedad
@export var attack_damage = 10
@export var attack_range = 50

func _process(_delta):
	match death:
		true:
			death_ctrl()
		false:
			motion_ctrl()

func _input(event):
	if not death and is_on_floor() and event.is_action_pressed("ui_accept"):
		jump_ctrl(1)

#Cambie de lugar "ui_right" por "ui_left" para arreglar el movimiento

func motion_ctrl() -> void:
	velocity.x = GLOBAL.get_axis().x * speed
	move_and_slide()
	
	# Ataque
	if Input.is_action_just_pressed("ui_attack") and can_attack:
		attack()
	
	match is_on_floor():
		true:
			if not GLOBAL.get_axis().x == 0:
				$Sprite.play("run")
			else:
				$Sprite.play("Idle")
		false:
			if velocity.y < 0:
				$Sprite.play("Jump")
			else:
				$Sprite.play("Fall")

func death_ctrl() -> void:
	velocity.x = 0
	velocity.y += gravity
	move_and_slide()
	$Sprite.play("Death")

func take_damage(damage: int):
	health -= damage
	print("Salud restante Jugador: ", health)
	if health <= 0 and not death:
		death = true
		death_ctrl()
		$Collision.set_deferred("disabled", true)
		gravity = 0
		_on_sprite_animation_finished()  # Llama a un método para manejar la muerte

func die():
	queue_free()  # Elimina el nodo del juego

func jump_ctrl(power : float) -> void:
	if Input.is_action_pressed("ui_jump"):
		velocity.y = -jump * power
		$Audio/Jump.play()

func damage_ctrl() -> void:
	death = true
	$Sprite.play("Death")

func attack():
	$Sprite.play("Attack")
	can_attack = false
	print("Atacando!")
	$AttackTimer.start()

func _on_AttackTimer_timeout():
	can_attack = true

func _on_hitpoint_body_entered(body: Node2D) -> void:
	# Verifica si el cuerpo que entró en el Area2D es un enemigo
	if body is Enemy and velocity.y >= 0:
		$Audio/Hit.play()
		body.take_damage(10)
		jump_ctrl(0.5)

func _on_sprite_animation_finished() -> void:
	if $Sprite.animation == "Death":
		die()
		gui.game_over()
