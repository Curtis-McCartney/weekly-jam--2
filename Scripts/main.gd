extends Node2D

@onready var player_scene: PackedScene = preload("res://Scenes/player.tscn")
@onready var level_holder: Node2D = %Level_Holder
@onready var speedrun_time_text: RichTextLabel = %Speedrun_Timer_Text
var speedrun_timer_is_on = false
var current_level: int
@onready var main_menu_scene: PackedScene = preload("res://Scenes/UI/main_menu.tscn")
@onready var level_1_scene: PackedScene = preload("res://Scenes/Levels/level_1.tscn")
@onready var level_2_scene: PackedScene = preload("res://Scenes/Levels/level_2.tscn")
@onready var level_3_scene: PackedScene = preload("res://Scenes/Levels/level_3.tscn")
@onready var level_4_scene: PackedScene = preload("res://Scenes/Levels/level_4.tscn")
@onready var level_5_scene: PackedScene = preload("res://Scenes/Levels/level_5.tscn")
@onready var level_6_scene: PackedScene = preload("res://Scenes/Levels/level_6.tscn")
@onready var level_7_scene: PackedScene = preload("res://Scenes/Levels/level_7.tscn")
@onready var level_8_scene: PackedScene = preload("res://Scenes/Levels/level_8.tscn")
@onready var level_9_scene: PackedScene = preload("res://Scenes/Levels/level_9.tscn")
@onready var level_10_scene: PackedScene = preload("res://Scenes/Levels/level_10.tscn")
@onready var level_11_scene: PackedScene = preload("res://Scenes/Levels/level_11.tscn")
var tween: Tween

# Audio Players
@onready var music: AudioStreamPlayer = %Music
@onready var player_jump_sound_effect: AudioStreamPlayer = %Player_Jump
@onready var bucket_pickup_sound_effect: AudioStreamPlayer = %Bucket_Pickup
@onready var bucket_explosion_sound_effect: AudioStreamPlayer = %Bucket_Explosion
@onready var win_door_sound_effect: AudioStreamPlayer = %Win_Door

func _ready() -> void:
	# Call Main Menu
	music.play()
	speedrun_timer_is_on = false
	current_level = 0
	load_level(current_level)

func player_at_win_door():
	var player = find_player()

	if player:
		player.at_win_door()
		reset_tween()
		tween.tween_property(player, "modulate:a", 0, 1)

func _process(_delta: float) -> void:
	if !find_player():
		return
	if Input.is_action_just_pressed("Restart") && find_player().player_allowed_to_input:
		call_deferred("load_level", current_level)
	if Input.is_action_just_pressed("Escape") && find_player().player_allowed_to_input:
		speedrun_time_text.quick_end()
		current_level = 0
		call_deferred("load_level", current_level)

func win_door_closed():
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
		4:
			level_to_instantiate = level_4_scene.instantiate()
		5:
			level_to_instantiate = level_5_scene.instantiate()
		6:
			level_to_instantiate = level_6_scene.instantiate()
		7:
			level_to_instantiate = level_7_scene.instantiate()
		8:
			level_to_instantiate = level_8_scene.instantiate()
		9:
			level_to_instantiate = level_9_scene.instantiate()
		10:
			level_to_instantiate = level_10_scene.instantiate()
		11:
			level_to_instantiate = level_11_scene.instantiate()
		_:
			printerr("Trying to load a level that does not exist!")
			return
	level_to_instantiate.position = Vector2(0,0)
	level_holder.add_child(level_to_instantiate)

func de_load_all_levels() -> void:
	for level in level_holder.get_children():
		level.queue_free()

func reset_tween() -> void:
	if tween:
		tween.kill()
	tween = create_tween()

func find_player() -> Node:
	if level_holder.get_child_count() == 0:
		print("No level loaded, so no Player loaded!")
		return

	var level_instance = level_holder.get_child(0)
	var player = level_instance.find_child("Player", true, false)

	if player:
		return player
	else:
		#print("Player not found!")
		return null

func play_pickup_bucket_sound_effect():
	bucket_pickup_sound_effect.play()

func play_jump_sound_effect():
	player_jump_sound_effect.play()

func play_bucket_explosion_sound_effect():
	bucket_explosion_sound_effect.play()

func play_win_door_sound_effect():
	win_door_sound_effect.play()
