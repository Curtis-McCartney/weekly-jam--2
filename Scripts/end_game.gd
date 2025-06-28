extends Node2D

@onready var you_win_text: RichTextLabel = %You_Win_Text
@onready var instructions_text: RichTextLabel = %Instructions
@onready var you_win_timer: Timer = %You_Win_Timer
var won = false

func _ready() -> void:
	you_win_text.visible = false
	instructions_text.visible = false
	won = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Enter") && won:
		get_tree().current_scene.speedrun_time_text.quick_end()
		get_tree().current_scene.current_level = 0
		get_tree().current_scene.load_level(0)

func end_game():
	get_tree().current_scene.find_child("Speedrun_Timer_Text").stop()
	you_win_timer.start()

func _on_you_win_timer_timeout() -> void:
	you_win_text.visible = true
	instructions_text.visible = true
	won = true
