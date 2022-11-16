extends Control

onready var time_survived = get_node("TimeSurvived")

var max_time setget set_time

func _ready():
	time_survived.text = max_time

func _on_ResetButton_pressed():
	get_tree().reload_current_scene()

func set_time(time: String):
	max_time = time
