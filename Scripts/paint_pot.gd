extends RigidBody2D

@export var paint_colour: Enums.Paint_Colour

# An all-purpose script for all type of paint cans
func _ready() -> void:
	var MASK_BLACK_WALL := 1 << 0
	var MASK_RED_WALL := 1 << 1
	var MASK_BLUE_WALL := 1 << 2
	var MASK_YELLOW_WALL := 1 << 3

	match paint_colour:
		Enums.Paint_Colour.RED:
			# Collides with everything except Red Wall
			collision_mask = MASK_BLACK_WALL | MASK_BLUE_WALL | MASK_YELLOW_WALL
		Enums.Paint_Colour.BLUE:
			# Collides with everything except Blue Wall
			collision_mask = MASK_BLACK_WALL | MASK_RED_WALL | MASK_YELLOW_WALL
		Enums.Paint_Colour.YELLOW:
			# Collides with everything except Yellow Wall
			collision_mask = MASK_BLACK_WALL | MASK_RED_WALL | MASK_BLUE_WALL
