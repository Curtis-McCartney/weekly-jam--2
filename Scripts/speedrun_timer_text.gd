extends RichTextLabel

var running := false
var time_elapsed := 0.0

func _ready() -> void:
	hide()

func _process(delta: float) -> void:
	if running:
		time_elapsed += delta
		text = format_time(time_elapsed)

func start():
	if get_tree().current_scene.speedrun_timer_is_on:
		show()
		time_elapsed = 0.0
		running = true
	

func stop():
	running = false

func resume():
	running = true

func reset():
	time_elapsed = 0.0

func format_time(seconds: float) -> String:
	var minutes = int(seconds / 60)
	var secs = int(seconds) % 60
	var millis = int((seconds - int(seconds)) * 100)
	return "%02d:%02d.%02d" % [minutes, secs, millis]
