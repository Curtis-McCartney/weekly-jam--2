extends RigidBody2D

@export var wall_colour: Enums.Paint_Colour

# An all-purpose script for all type of wall
func _ready() -> void:
	#var LAYER_BLACK_WALL := 1 << 0
	var LAYER_RED_WALL := 1 << 1
	var LAYER_BLUE_WALL := 1 << 2
	var LAYER_YELLOW_WALL := 1 << 3

	match wall_colour:
		Enums.Paint_Colour.RED:
			#collision_mask = LAYER_RED_WALL
			collision_layer = LAYER_RED_WALL
		Enums.Paint_Colour.BLUE:
			#collision_mask = LAYER_BLUE_WALL
			collision_layer = LAYER_BLUE_WALL
		Enums.Paint_Colour.YELLOW:
			#collision_mask = LAYER_YELLOW_WALL
			collision_layer = LAYER_YELLOW_WALL

func _on_body_entered(body: Node) -> void:
	print("Body entered")
	if body.is_in_group("Paint_Pot"):
		body.hit_wall()
