extends RigidBody2D

@export var paint_colour: Enums.Paint_Colour
@onready var paint_pot_sprite: AnimatedSprite2D = %Paint_Pot_Sprite
@onready var paint_particles: PackedScene = preload("res://Scenes/paint_particles.tscn")
@export var speed: float = 450

const LAYER_BLACK := 1 << 0
const LAYER_RED_WALL := 1 << 1
const LAYER_BLUE_WALL := 1 << 2
const LAYER_YELLOW_WALL := 1 << 3
const LAYER_PLAYER := 1 << 4

func _ready():
	match paint_colour:
		Enums.Paint_Colour.RED:
			paint_pot_sprite.play("Red")
			collision_mask = LAYER_BLACK | LAYER_BLUE_WALL | LAYER_YELLOW_WALL
		Enums.Paint_Colour.BLUE:
			paint_pot_sprite.play("Blue")
			collision_mask = LAYER_BLACK | LAYER_RED_WALL | LAYER_YELLOW_WALL
		Enums.Paint_Colour.YELLOW:
			paint_pot_sprite.play("Yellow")
			collision_mask = LAYER_BLACK | LAYER_RED_WALL | LAYER_BLUE_WALL
	
	# Set spin speed (degrees per second → radians per second)
	angular_velocity = deg_to_rad(speed)  # 60 degrees/sec clockwise
	
	# Temporarily avoid colliding with the player who threw this
	collision_mask &= ~LAYER_PLAYER
	await get_tree().create_timer(0.5).timeout
	if get_tree().current_scene.find_player().current_player_colour == paint_colour:
		return
	collision_mask |= LAYER_PLAYER

func hit_wall(wall: Node):
	print("Hit the Wall!")
	wall.change_wall_colour(paint_colour)

func hit_player(player: Node):
	print("Hit the Player!")
	player.change_player_colour(paint_colour)

func _on_body_entered(body: Node) -> void:
	# This is called whenever a paint pot hits anything
	create_paint_particles()
	if body.is_in_group("Coloured_Wall"):
		hit_wall(body)
	elif body.is_in_group("Player"):
		hit_player(body)
	kill_paint_bucket()

func kill_paint_bucket():
	# Do Animation Stuff here later
	queue_free()

func create_paint_particles():
	print("Creating particles")
	var particles_to_instantiate = paint_particles.instantiate()
	particles_to_instantiate.global_position = global_position
	get_tree().current_scene.find_child("Level_Holder").get_child(0).add_child(particles_to_instantiate)
	get_tree().current_scene.play_bucket_explosion_sound_effect()
	particles_to_instantiate.set_emitting(true)
