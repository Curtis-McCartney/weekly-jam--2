extends Area2D

@export var bucket_colour: Enums.Paint_Colour
@onready var animated_sprite: AnimatedSprite2D = %Bucket_Animation

func _ready() -> void:
	match bucket_colour:
		Enums.Paint_Colour.RED:
			animated_sprite.play("Red")
		Enums.Paint_Colour.BLUE:
			animated_sprite.play("Blue")
		Enums.Paint_Colour.YELLOW:
			animated_sprite.play("Yellow")
		Enums.Paint_Colour.BLACK:
			animated_sprite.play("Black")

func _on_body_entered(body: Node2D) -> void:
	print("Body entered")
	if body.is_in_group("Player"):
		print("Player is grabbing paint bucket")
		body.currently_held_paint_can = bucket_colour
		get_tree().current_scene.play_pickup_bucket_sound_effect()
		queue_free()
