extends CharacterBody2D

@export var speed = 300.0
@export var jump_velocity = -400.0
@onready var animated_sprite: AnimatedSprite2D = %Player_Animated_Sprite

@export var current_player_colour: Enums.Paint_Colour
@export var currently_held_paint_can: Enums.Paint_Colour

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

func change_player_colour(colour_to_change_to) -> void:
	current_player_colour = colour_to_change_to
	
	var MASK_BLACK_WALL := 1 << 0
	var MASK_RED := 1 << 1
	var MASK_BLUE := 1 << 2
	var MASK_YELLOW := 1 << 3
	
	match current_player_colour:
		Enums.Paint_Colour.RED:
			collision_mask = MASK_BLUE | MASK_YELLOW | MASK_BLACK_WALL
			collision_layer = MASK_BLUE | MASK_YELLOW | MASK_BLACK_WALL
		Enums.Paint_Colour.BLUE:
			collision_mask = MASK_RED | MASK_YELLOW | MASK_BLACK_WALL
			collision_layer = MASK_RED | MASK_YELLOW | MASK_BLACK_WALL
		Enums.Paint_Colour.YELLOW:
			collision_mask = MASK_RED | MASK_BLUE | MASK_BLACK_WALL
			collision_layer = MASK_RED | MASK_BLUE | MASK_BLACK_WALL
