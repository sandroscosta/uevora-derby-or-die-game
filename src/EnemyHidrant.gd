extends KinematicBody2D

export var health:= 15.0
export var damage:= 1.5

var speed:= 85.0
var velocity:= Vector2.ZERO

onready var player = get_tree().get_nodes_in_group("player")[0]

func _physics_process(delta):
	var direction = global_position.direction_to(player.global_position)
	
	velocity = direction * speed
	move_and_slide(velocity)
