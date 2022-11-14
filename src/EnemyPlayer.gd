extends KinematicBody2D

export var health = 30

var wheel_base = 75  # Distance from front to rear wheel
var steering_angle = 5  # Amount that front wheel turns, in degrees

var velocity = Vector2.ZERO
var steer_angle # Calculated steering angle

var engine_power = 600  # Forward acceleration force.
var acceleration = Vector2.ZERO

var friction = -0.9
var drag = -0.0015

var braking = -450
var max_speed_reverse = 250

var turn = 0

onready var player = get_tree().get_nodes_in_group("player")[0]

func _physics_process(delta):
	acceleration = Vector2.ZERO
	#apply_friction()

	var direction = player.position
	
	print(direction)
	
	if direction.x > 0.1:
		turn -= 1
	elif direction.x < -0.1:
		turn += 1
	
	steer_angle = turn * steering_angle
	acceleration = transform.x * engine_power
	calculate_steering(delta)
	
	velocity += direction * delta
	velocity = move_and_slide(velocity)

func calculate_steering(delta):
	var rear_wheel = position - transform.x * wheel_base / 2.0
	var front_wheel = position + transform.x * wheel_base / 2.0
	rear_wheel += velocity * delta
	front_wheel += velocity.rotated(steer_angle) * delta
	var new_heading = (front_wheel - rear_wheel).normalized()
	var d = new_heading.dot(velocity.normalized())
	if d > 0:
		velocity = new_heading * velocity.length()
	if d < 0:
		velocity = -new_heading * min(velocity.length(), max_speed_reverse)
	rotation = new_heading.angle()
