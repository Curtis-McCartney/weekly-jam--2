extends Node2D

@onready var animation_sprite: AnimatedSprite2D = %Bucket_Animation
@export var player: CharacterBody2D

func _ready() -> void:
	visible = false

func _process(_delta: float) -> void:
	if visible:
		if player.currently_held_paint_can == Enums.Paint_Colour.NONE:
			animation_sprite.hide()
		else:
			animation_sprite.show()
		match player.currently_held_paint_can:
			Enums.Paint_Colour.RED:
				animation_sprite.play("Red")
			Enums.Paint_Colour.BLUE:
				animation_sprite.play("Blue")
			Enums.Paint_Colour.YELLOW:
				animation_sprite.play("Yellow")
		
