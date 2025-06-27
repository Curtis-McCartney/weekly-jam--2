extends StaticBody2D

@export var wall_colour: Enums.Paint_Colour
@export var animated_wall_sprite: AnimatedSprite2D
@export var player_tracking_area: Area2D

const LAYER_RED_WALL := 1 << 1
const LAYER_BLUE_WALL := 1 << 2
const LAYER_YELLOW_WALL := 1 << 3
const LAYER_PLAYER := 1 << 4

var player: Node

# An all-purpose script for all type of wall
func _ready() -> void:
	player_tracking_area.collision_mask = LAYER_PLAYER
	change_wall_colour(wall_colour)

func change_wall_colour(new_wall_colour: Enums.Paint_Colour) -> void:
	wall_colour = new_wall_colour
	if player:
		player.currently_on_wall = false
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

func _on_player_tracking_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		player = body
		if body.current_player_colour != wall_colour:
			body.currently_on_wall = true
			print(body.currently_on_wall, " on wall!")
		else:
			body.currently_on_wall = false

func _on_player_tracking_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.currently_on_wall = false
		print(body.currently_on_wall, " on wall!")
