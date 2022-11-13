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
