extends Node2D

enum EnemyType {CONE, HIDRANT, LIGHTS}
enum GameStateType {RUNNING, STOPPED}

var gamestate = GameStateType.RUNNING

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
onready var endgame_ui = preload ("res://src/EndGameScreen.tscn")
onready var alive_time = get_node("UI/AliveTimer")

onready var player = get_node("PlayerCar")

var endgame

func _ready():
	endgame = endgame_ui.instance()
	timer.start()
	
#func _process(delta):
#	print(player.health)
#	if player.health <= 0:
#		end_game()

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


func _on_PlayerCar_dead():
	end_game()
	
func end_game():
	var player = get_tree().get_nodes_in_group("player")[0]
	var enemies = get_tree().get_nodes_in_group("enemy")
	alive_time.stop_timer()
	endgame = endgame_ui.instance()
	endgame.set_time("You survived for %s" % alive_time.format_timer())
	
	timer.stop()
	
	for enemy in enemies:
		enemy.set_physics_process(false)
	
	player.set_physics_process(false)
	
	add_child(endgame)
