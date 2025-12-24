extends Node2D


@onready var playback: AnimationNodeStateMachinePlayback = $Metodo2/AnimationTree.get("parameters/playback")

func _process(delta) -> void:
	state_machine()

func state_machine() -> void:
	match playback.get_current_node():
		"Attack":
			pass
		"Run":
			pass

func _ready():
	$Sprite2D/AnimationPlayer.play("attack")
	$Sprite2D/AnimationPlayer.stop("attack")
	playback.travel("Run")

func demo():
	pass

func _on_animation_player_animation_started(anim_name):
	match anim_name:
		"Attack":
			pass
		"Run":
			pass

func _on_animation_player_animation_finished(anim_name):
	match anim_name:
		"Attack":
			pass
		"Run":
			pass
