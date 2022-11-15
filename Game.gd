extends Node2D

var endgame = false
enum EnemyType {CONE, HIDRANT, LIGHTS}

# Have 4 standard postions for the enemies to spawn on.
var EnemyPosition = [
	Vector2(80, 80),
	Vector2(80, 500),
	Vector2(950, 80),
	Vector2(950, 500)
]

var enemy_cone = preload ("res://src/EnemyCone.tscn")
var enemy_lights = preload ("res://src/EnemySignal.tscn")
var enemy_hidrant = preload ("res://src/EnemyHidrant.tscn")

onready var timer = get_node("EnemySpawnTimer")

func _ready():
	timer.start()

func _on_EnemySpawnTimer_timeout():
	var enemy
	var enemy_type = randi() % 3
	
	match enemy_type:
		EnemyType.CONE:
			enemy = enemy_cone.instance()
		EnemyType.HIDRANT:
			enemy = enemy_hidrant.instance()
		EnemyType.LIGHTS:
			enemy = enemy_lights.instance()
	
	var initial_position = randi() % len(EnemyPosition)
	
	enemy.position = EnemyPosition[initial_position]
	add_child(enemy)
