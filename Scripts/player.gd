extends CharacterBody2D

@export var speed = 300.0
@export var jump_velocity = -400.0
@onready var animated_sprite: AnimatedSprite2D = %Player_Animated_Sprite

@export var current_player_colour: Enums.Paint_Colour
@export var currently_held_paint_can: Enums.Paint_Colour

const LAYER_PLAYER_RED := 1 << 4
const LAYER_PLAYER_BLUE := 1 << 5
const LAYER_PLAYER_YELLOW := 1 << 6
const LAYER_BLACK := 1 << 0
const LAYER_RED_WALL := 1 << 1
const LAYER_BLUE_WALL := 1 << 2
const LAYER_YELLOW_WALL := 1 << 3

func _ready() -> void:
	currently_held_paint_can = Enums.Paint_Colour.RED
	change_player_colour(Enums.Paint_Colour.RED)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = jump_velocity

	# Get the input direction and handle the movement/deceleration.
	var direction := Input.get_axis("Move_Left", "Move_Right")
	if direction:
		velocity.x = direction * speed
		animated_sprite.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()

func change_player_colour(colour_to_change_to: Enums.Paint_Colour):
	match colour_to_change_to:
		Enums.Paint_Colour.RED:
			#collision_layer = LAYER_PLAYER_RED
			collision_mask = LAYER_BLACK | LAYER_BLUE_WALL | LAYER_YELLOW_WALL
		Enums.Paint_Colour.BLUE:
			#collision_layer = LAYER_PLAYER_BLUE
			collision_mask = LAYER_BLACK | LAYER_RED_WALL | LAYER_YELLOW_WALL
		Enums.Paint_Colour.YELLOW:
			#collision_layer = LAYER_PLAYER_YELLOW
			collision_mask = LAYER_BLACK | LAYER_RED_WALL | LAYER_BLUE_WALL
