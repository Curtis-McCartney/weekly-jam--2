extends RigidBody2D

@export var wall_colour: Enums.Paint_Colour

# An all-purpose script for all type of wall
func _ready() -> void:
	#var MASK_BLACK_WALL := 1 << 0
	var MASK_RED_WALL := 1 << 1
	var MASK_BLUE_WALL := 1 << 2
	var MASK_YELLOW_WALL := 1 << 3

	match wall_colour:
		Enums.Paint_Colour.RED:
			#collision_mask = MASK_RED_WALL
			collision_layer = MASK_RED_WALL
		Enums.Paint_Colour.BLUE:
			#collision_mask = MASK_BLUE_WALL
			collision_layer = MASK_BLUE_WALL
		Enums.Paint_Colour.YELLOW:
			#collision_mask = MASK_YELLOW_WALL
			collision_layer = MASK_YELLOW_WALL

func _on_body_entered(body: Node) -> void:
	print("Body entered")
