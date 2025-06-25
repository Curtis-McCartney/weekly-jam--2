extends RigidBody2D

@export var speed: float = 600.0
@export var gravity: float = 1.0
var thrown_direction

func _process(delta: float) -> void:
	position -= thrown_direction * speed * delta
