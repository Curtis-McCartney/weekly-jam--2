extends RigidBody2D

@export var wall_colour: Enums.Paint_Colour
@export var animated_wall_sprite: AnimatedSprite2D

const LAYER_RED_WALL := 1 << 1
const LAYER_BLUE_WALL := 1 << 2
const LAYER_YELLOW_WALL := 1 << 3

# An all-purpose script for all type of wall
func _ready() -> void:
	change_wall_colour(wall_colour)

func change_wall_colour(new_wall_colour: Enums.Paint_Colour) -> void:
	match new_wall_colour:
		Enums.Paint_Colour.RED:
			animated_wall_sprite.play("Red")
			collision_layer = LAYER_RED_WALL
		Enums.Paint_Colour.BLUE:
			animated_wall_sprite.play("Blue")
			collision_layer = LAYER_BLUE_WALL
		Enums.Paint_Colour.YELLOW:
			animated_wall_sprite.play("Yellow")
			collision_layer = LAYER_YELLOW_WALL
