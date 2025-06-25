extends RigidBody2D

@export var paint_colour: Enums.Paint_Colour

const LAYER_BLACK := 1 << 0
const LAYER_RED_WALL := 1 << 1
const LAYER_BLUE_WALL := 1 << 2
const LAYER_YELLOW_WALL := 1 << 3
const LAYER_PLAYER_RED := 1 << 4
const LAYER_PLAYER_BLUE := 1 << 5
const LAYER_PLAYER_YELLOW := 1 << 6

func _ready():
	var player = get_tree().current_scene.find_child("Player")
	var player_layer: int
	#match player.current_player_colour:
		#Enums.Paint_Colour.RED:
			#player_layer = LAYER_PLAYER_RED
		#Enums.Paint_Colour.BLUE:
			#player_layer = LAYER_PLAYER_BLUE
		#Enums.Paint_Colour.YELLOW:
			#player_layer = LAYER_PLAYER_YELLOW
	
	match paint_colour:
		Enums.Paint_Colour.RED:
			collision_mask = LAYER_BLACK | LAYER_BLUE_WALL | LAYER_YELLOW_WALL
		Enums.Paint_Colour.BLUE:
			collision_mask = LAYER_BLACK | LAYER_RED_WALL | LAYER_YELLOW_WALL
		Enums.Paint_Colour.YELLOW:
			collision_mask = LAYER_BLACK | LAYER_RED_WALL | LAYER_BLUE_WALL

	# Temporarily avoid colliding with the player who threw this
	#collision_mask &= ~player_layer
	#await get_tree().create_timer(0.1).timeout
	#collision_mask |= player_layer

func hit_wall():
	print("Hit the Wall!")
	queue_free()
