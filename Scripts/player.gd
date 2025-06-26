extends CharacterBody2D

@export var speed = 200.0
@export var jump_velocity = -400.0
@onready var animated_sprite: AnimatedSprite2D = %Player_Animated_Sprite
@export var current_player_colour: Enums.Paint_Colour
@export var currently_held_paint_can: Enums.Paint_Colour

const LAYER_PLAYER := 1 << 4
const LAYER_BLACK := 1 << 0
const LAYER_RED_WALL := 1 << 1
const LAYER_BLUE_WALL := 1 << 2
const LAYER_YELLOW_WALL := 1 << 3

func _ready() -> void:
	currently_held_paint_can = Enums.Paint_Colour.NONE
	change_player_colour(Enums.Paint_Colour.RED)

func _process(_delta: float) -> void:
	pass
	#if Input.is_action_just_pressed("One"):
		#currently_held_paint_can = Enums.Paint_Colour.RED
	
	#if Input.is_action_just_pressed("Two"):
		#currently_held_paint_can = Enums.Paint_Colour.BLUE
	
	#if Input.is_action_just_pressed("Three"):
		#currently_held_paint_can = Enums.Paint_Colour.YELLOW
	

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
		match current_player_colour:
			Enums.Paint_Colour.RED:
				animated_sprite.play("Red_Run")
			Enums.Paint_Colour.BLUE:
				animated_sprite.play("Blue_Run")
			Enums.Paint_Colour.YELLOW:
				animated_sprite.play("Yellow_Run")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	if velocity == Vector2.ZERO:
		match current_player_colour:
			Enums.Paint_Colour.RED:
				animated_sprite.play("Red_Idle")
			Enums.Paint_Colour.BLUE:
				animated_sprite.play("Blue_Idle")
			Enums.Paint_Colour.YELLOW:
				animated_sprite.play("Yellow_Idle")
	
	move_and_slide()

func change_player_colour(new_player_colour: Enums.Paint_Colour):
	match new_player_colour:
		Enums.Paint_Colour.NONE:
			printerr("Changed player colour to none??")
			return
		Enums.Paint_Colour.RED:
			collision_layer = LAYER_PLAYER
			collision_mask = LAYER_BLACK | LAYER_BLUE_WALL | LAYER_YELLOW_WALL
		Enums.Paint_Colour.BLUE:
			collision_layer = LAYER_PLAYER
			collision_mask = LAYER_BLACK | LAYER_RED_WALL | LAYER_YELLOW_WALL
		Enums.Paint_Colour.YELLOW:
			collision_layer = LAYER_PLAYER
			collision_mask = LAYER_BLACK | LAYER_RED_WALL | LAYER_BLUE_WALL
	current_player_colour = new_player_colour
