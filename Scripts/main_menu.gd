extends Control

var main_scene
@export var level_select_panel: Panel
@export var settings_panel: Panel
var level_selecting_position = Vector2(-324, -183)
var level_select_hiding_position = Vector2(-324, 389)

@onready var level_button_1: Button = %Level_1_Button
@onready var level_button_2: Button = %Level_2_Button
@onready var level_button_3: Button = %Level_3_Button
@onready var level_button_4: Button = %Level_4_Button
@onready var level_button_5: Button = %Level_5_Button
@onready var level_button_6: Button = %Level_6_Button
@onready var level_button_7: Button = %Level_7_Button
@onready var level_button_8: Button = %Level_8_Button
@onready var level_button_9: Button = %Level_9_Button
@onready var level_button_10: Button = %Level_10_Button
@onready var next_page_button: Button = %Next_Page_Button
@onready var previous_page_button: Button = %Previous_Page_Button
var current_page = 1


@onready var speedrun_timer_button: Button = %Speedrun_Timer_Button

func _ready() -> void:
	main_scene = get_tree().current_scene
	level_select_panel.global_position = level_select_hiding_position
	settings_panel.global_position = level_select_hiding_position
	if get_tree().current_scene.speedrun_timer_is_on:
		speedrun_timer_button.add_theme_color_override("font_color", Color(0.0, 1.0, 0.0)) # Green
		print("Green")
	else:
		speedrun_timer_button.add_theme_color_override("font_color", Color(1.0, 0.0, 0.0)) # Red
		print("Red")

func _on_new_game_button_pressed() -> void:
	main_scene.current_level = 1
	main_scene.load_level(main_scene.current_level)
	get_tree().current_scene.find_child("Speedrun_Timer_Text").start()

func _on_level_select_button_pressed() -> void:
	open_level_select()

func _on_settings_button_pressed() -> void:
	open_settings_menu()

func _on_level_1_button_pressed() -> void:
	main_scene.current_level = 1
	main_scene.load_level(main_scene.current_level)

func _on_level_2_button_pressed() -> void:
	main_scene.current_level = 2
	main_scene.load_level(main_scene.current_level)

func _on_level_3_button_pressed() -> void:
	main_scene.current_level = 3
	main_scene.load_level(main_scene.current_level)

func _on_level_4_button_pressed() -> void:
	main_scene.current_level = 4
	main_scene.load_level(main_scene.current_level)

func _on_level_5_button_pressed() -> void:
	main_scene.current_level = 5
	main_scene.load_level(main_scene.current_level)

func _on_level_6_button_pressed() -> void:
	main_scene.current_level = 6
	main_scene.load_level(main_scene.current_level)

func _on_level_7_button_pressed() -> void:
	main_scene.current_level = 7
	main_scene.load_level(main_scene.current_level)

func _on_level_8_button_pressed() -> void:
	main_scene.current_level = 8
	main_scene.load_level(main_scene.current_level)

func _on_level_9_button_pressed() -> void:
	main_scene.current_level = 9
	main_scene.load_level(main_scene.current_level)

func _on_level_10_button_pressed() -> void:
	main_scene.current_level = 10
	main_scene.load_level(main_scene.current_level)

func _on_next_page_button_pressed() -> void:
	match current_page:
		1:
			to_page_two()
		2:
			to_page_three()
	current_page += 1

func _on_previous_page_button_pressed() -> void:
	match current_page:
		1:
			close_level_select()
		2:
			to_page_one()
		3:
			to_page_two()
	current_page -= 1

func to_page_one():
	level_button_1.visible = true
	level_button_2.visible = true
	level_button_3.visible = true
	level_button_4.visible = true
	level_button_5.visible = false
	level_button_6.visible = false
	level_button_7.visible = false
	level_button_8.visible = false
	level_button_9.visible = false
	level_button_10.visible = false
	next_page_button.visible = true
	previous_page_button.visible = true

func to_page_two():
	level_button_1.visible = false
	level_button_2.visible = false
	level_button_3.visible = false
	level_button_4.visible = false
	level_button_5.visible = true
	level_button_6.visible = true
	level_button_7.visible = true
	level_button_8.visible = true
	level_button_9.visible = false
	level_button_10.visible = false
	next_page_button.visible = true
	previous_page_button.visible = true

func to_page_three():
	level_button_1.visible = false
	level_button_2.visible = false
	level_button_3.visible = false
	level_button_4.visible = false
	level_button_5.visible = false
	level_button_6.visible = false
	level_button_7.visible = false
	level_button_8.visible = false
	level_button_9.visible = true
	level_button_10.visible = true
	next_page_button.visible = false
	previous_page_button.visible = true

func open_level_select():
	level_select_panel.global_position = level_selecting_position
	current_page = 1
	to_page_one()

func close_level_select():
	level_select_panel.global_position = level_select_hiding_position

func open_settings_menu():
	settings_panel.global_position = level_selecting_position

func close_settings_menu():
	settings_panel.global_position = level_select_hiding_position

func _on_speedrun_timer_pressed() -> void:
	if get_tree().current_scene.speedrun_timer_is_on:
		speedrun_timer_button.add_theme_color_override("font_color", Color(1.0, 0.0, 0.0))
		get_tree().current_scene.speedrun_timer_is_on = false
	else:
		speedrun_timer_button.add_theme_color_override("font_color", Color(0.0, 1.0, 0.0))
		get_tree().current_scene.speedrun_timer_is_on = true

func _on_leave_settings_button_pressed() -> void:
	close_settings_menu()
