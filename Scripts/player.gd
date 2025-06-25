extends CharacterBody2D

@export var speed = 300.0
@export var jump_velocity = -400.0
@onready var animated_sprite: AnimatedSprite2D = %Player_Animated_Sprite

func _ready() -> void:
	pass

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
