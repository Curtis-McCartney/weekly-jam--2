extends Node2D

@onready var paint_pot_scene: PackedScene = preload("res://Scenes/paint_pot.tscn")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Mouse_Click"):
		shoot_paint_pot()

func shoot_paint_pot():
	var pot_to_instantiate = paint_pot_scene.instantiate()
	pot_to_instantiate.global_position = global_position
	pot_to_instantiate.thrown_direction = (position - get_global_mouse_position()).normalized()
	
	get_tree().current_scene.add_child(pot_to_instantiate)
