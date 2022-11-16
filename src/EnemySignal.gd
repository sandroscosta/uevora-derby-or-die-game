extends KinematicBody2D

export var health:= 25.0
export var damage:= 3.0

var speed:= 45.0
var velocity:= Vector2.ZERO

onready var player = get_tree().get_nodes_in_group("player")[0]

func _physics_process(_delta):
	var direction = global_position.direction_to(player.global_position)
	
	velocity = direction * speed
	move_and_slide(velocity)

func disable():
	self.set_physics_process(false)

func enable():
	self.set_physics_process(true)
