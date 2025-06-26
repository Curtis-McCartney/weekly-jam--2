extends Area2D

@onready var animated_sprite: AnimatedSprite2D = %Animated_Door_Sprite
var main_scene: Node

func _ready() -> void:
	main_scene = get_tree().current_scene
	animated_sprite.play("Idle")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		print("Player is at door to leave!")
		animated_sprite.play("Opening_Closing")

func _on_animated_door_sprite_animation_finished() -> void:
	if animated_sprite.animation == "Closing":
		main_scene.player_at_win_door()
