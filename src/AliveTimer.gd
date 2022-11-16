extends Control

var active = false
var timer:= 0.0
onready var label = get_node("Label")

func _ready() -> void:
	label.text = "00:00:00"
	start_timer()

func _process(delta: float) -> void:
	if active:
		timer += delta
	label.text = format_timer()

func format_timer() -> String:
	var minutes := timer / 60
	var seconds := fmod(timer, 60)
	var milliseconds := fmod(timer, 1) * 100
	return "%02d:%02d:%02d" % [minutes, seconds, milliseconds]

func reset_timer():
	timer = 0.0

func start_timer():
	active = true

func stop_timer():
	active = false	
