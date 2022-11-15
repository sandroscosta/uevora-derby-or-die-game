extends Control

onready var player = get_tree().get_nodes_in_group("player")[0]
onready var health_bar = get_node("HealthBar")

func update_health(value: float):
	health_bar.rect_size = Vector2(value, health_bar.rect_size.y)
