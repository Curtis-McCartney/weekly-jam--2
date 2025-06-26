extends Node2D

@onready var paint_pot_scene: PackedScene = preload("res://Scenes/paint_pot.tscn")
@export var paint_can_speed: float = 400.0
@export var player: CharacterBody2D
var pot_to_instantiate
var pot_made: bool
var show_trajectory := false
var cached_trajectory_dir := Vector2.ZERO

func _ready() -> void:
	pot_made = false

func _process(_delta: float) -> void:
	if Input.is_action_pressed("Mouse_Click"):
		if player.currently_held_paint_can == Enums.Paint_Colour.NONE:
			return
		show_trajectory = true
		ready_paint_pot()
		queue_redraw()
	elif Input.is_action_just_released("Mouse_Click"):
		if player.currently_held_paint_can == Enums.Paint_Colour.NONE:
			return
		show_trajectory = false
		shoot_pot()
		queue_redraw()  # Clear the line

		
func ready_paint_pot():
	if !pot_made:
		pot_to_instantiate = paint_pot_scene.instantiate()
		pot_made = true
	cached_trajectory_dir = global_position.direction_to(get_global_mouse_position())
	pot_to_instantiate.linear_velocity = paint_can_speed * cached_trajectory_dir
	pot_to_instantiate.global_position = global_position
	pot_to_instantiate.paint_colour = player.currently_held_paint_can


func shoot_pot():
	get_tree().current_scene.add_child(pot_to_instantiate)
	pot_made = false
	player.currently_held_paint_can = Enums.Paint_Colour.NONE

func _draw() -> void:
	if show_trajectory:
		update_trajectory()


func get_forward_direction() -> Vector2:
	return global_position.direction_to(get_global_mouse_position())

func update_trajectory() -> void:
	var velocity : Vector2 = paint_can_speed * cached_trajectory_dir
	var line_start := global_position
	var line_end: Vector2
	var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity") * 0.6
	var drag: float = ProjectSettings.get_setting("physics/2d/default_linear_damp")
	var timestep := 0.02
	var colors := [Color.RED, Color.BLUE]
	
	for i:int in 70:
		velocity.y += gravity * timestep
		line_end = line_start + (velocity * timestep)
		velocity = velocity * clampf(1.0 - drag * timestep, 0, 1)
		
		var ray := raycast_query2d(line_start, line_end)
		# If it hits something
		if not ray.is_empty():
			break
		
		draw_line_global(line_start, line_end, colors[i%2])
		line_start = line_end

func raycast_query2d(pointA:Vector2, pointB:Vector2) -> Dictionary:
	var space_state := get_world_2d().direct_space_state
	var query := PhysicsRayQueryParameters2D.create(pointA, pointB, 1)
	var result := space_state.intersect_ray(query)
	
	if result:
		return result
	
	return {}

func draw_line_global(pointA:Vector2, pointB:Vector2, color:Color, width:int = -1) -> void:
	var local_offset := pointA - global_position
	var pointB_local := pointB - global_position
	draw_line(local_offset, pointB_local, color, width)
