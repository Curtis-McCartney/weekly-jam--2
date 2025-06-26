extends Node2D

@onready var player_scene: PackedScene = preload("res://Scenes/player.tscn")
@onready var level_holder: Node2D = %Level_Holder
var current_level: int
@onready var main_menu_scene: PackedScene = preload("res://Scenes/UI/main_menu.tscn")
@onready var level_1_scene: PackedScene = preload("res://Scenes/Levels/level_1.tscn")
@onready var level_2_scene: PackedScene = preload("res://Scenes/Levels/level_2.tscn")
@onready var level_3_scene: PackedScene = preload("res://Scenes/Levels/level_3.tscn")

func _ready() -> void:
	# Call Main Menu
	current_level = 1
	load_level(current_level)

func player_at_win_door():
	current_level += 1
	call_deferred("load_level", current_level)

func load_level(level_to_load) -> void:
	print("Should be loading level!")
	de_load_all_levels()
	var level_to_instantiate
	
	match level_to_load:
		0:
			level_to_instantiate = main_menu_scene.instantiate()
		1:
			level_to_instantiate = level_1_scene.instantiate()
		2:
			level_to_instantiate = level_2_scene.instantiate()
		3:
			level_to_instantiate = level_3_scene.instantiate()
		_:
			printerr("Trying to load a level that does not exist!")
			return
	level_to_instantiate.position = Vector2(0,0)
	level_holder.add_child(level_to_instantiate)

func de_load_all_levels() -> void:
	for level in level_holder.get_children():
		level.queue_free()
