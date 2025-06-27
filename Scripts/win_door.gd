extends Area2D

@onready var animated_sprite: AnimatedSprite2D = %Animated_Door_Sprite
var main_scene: Node
var player_currently_in_hitbox: bool
var player: Node

func _ready() -> void:
	main_scene = get_tree().current_scene
	animated_sprite.play("Idle")

func _process(_delta: float) -> void:
	if player_currently_in_hitbox:
		if player.is_on_floor():
			player_currently_in_hitbox = false
			print("Player is at door to leave!")
			main_scene.player_at_win_door()
			animated_sprite.play("Opening")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_currently_in_hitbox = true
		player = body

func _on_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player_currently_in_hitbox = false

func _on_animated_door_sprite_animation_finished() -> void:
	if animated_sprite.animation == "Opening":
		animated_sprite.play("Closing")
	if animated_sprite.animation == "Closing":
		main_scene.win_door_closed()
