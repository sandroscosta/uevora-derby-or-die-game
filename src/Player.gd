extends KinematicBody2D

export var health = 200

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

func _ready():
	print(get_viewport().size)

func _physics_process(delta):
	acceleration = Vector2.ZERO
	get_input()
	apply_friction()
	calculate_steering(delta)
	velocity += acceleration * delta
	velocity = move_and_slide(velocity)
	
	if get_slide_count() > 0 :
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			var body = collision.collider
			if body.is_in_group("enemy"):
				print("BOOM ", body.name)

func apply_friction():
	if velocity.length() < 5:
		velocity = Vector2.ZERO
	var friction_force = velocity * friction
	var drag_force = velocity * velocity.length() * drag
	if velocity.length() < 100:
		friction_force *= 3
	acceleration += drag_force + friction_force
	
func get_input():
	var turn = 0
	if Input.is_action_pressed("ui_right"):
		turn -= 1
	if Input.is_action_pressed("ui_left"):
		turn += 1
	steer_angle = turn * steering_angle
	if Input.is_action_pressed("ui_up"):
		acceleration = transform.x * engine_power
	if Input.is_action_pressed("ui_down"):
		acceleration = transform.x * braking

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
	
