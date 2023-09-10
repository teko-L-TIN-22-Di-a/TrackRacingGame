class_name Player
extends Spatial

export var default_fov: float = 70
export var max_fov: float = 90
export var gravity: float = 8.1
export var terminal_velocity: float = 100

export var engine_force: float = 15
export var vehicle_size: float = 1
export var steering_limit: float = 10

export var brake_force: float = 10
export var drag: float = 2
export var friction: float = 2

export var slip_speed: float = 15
export var traction_slow: float = 0.75
export var traction_fast: float = 0.02

export var max_speed: float = 20
export var max_reverse_speed: float = 5

onready var body: KinematicBody = $'KinematicBody'
onready var state_handler: StateHandler = $'KinematicBody/StateHandler'
onready var camera: Camera = $'Camera'

var velocity = Vector3.ZERO
var acceleration = Vector3.ZERO
var current_steering: float = 0
var drifting = false

func _process(delta: float):
	
	animate_camera(delta)
	
	state_handler.process(delta)
	
	apply_friction(delta)
	calculate_steering(delta)
	acceleration.y -= move_toward(gravity, terminal_velocity, delta)
	
	velocity += acceleration * delta
	
	velocity = body.move_and_slide_with_snap(velocity, -body.transform.basis.y, Vector3.UP, false)
	
func animate_camera(delta: float) -> void:
	var is_moving = state_handler.state.name in ["Moving", "Air"]
	
	if(is_moving):
		var speed_factor = velocity.length() / max_speed
		var new_fov = 70 + speed_factor * (max_fov - default_fov)
		camera.fov = lerp(camera.fov, new_fov, delta)
	else:
		camera.fov = lerp(camera.fov, default_fov, delta)
	
func apply_friction(delta: float) -> void:
	if(velocity.length() < 0.2 and acceleration.length() == 0):
		velocity.x = 0
		velocity.z = 0
	
	var friction_force = velocity * -friction * delta
	var drag_force = velocity * velocity.length() * -drag * delta
	acceleration += drag_force + friction_force
	
func calculate_steering(delta: float) -> void:
	# Calculate new direction
	var rear_pos = body.transform.origin + body.transform.basis.z * vehicle_size / 2.0
	var front_pos = body.transform.origin - body.transform.basis.z * vehicle_size / 2.0
	rear_pos += velocity * delta
	front_pos += velocity.rotated(body.transform.basis.y, current_steering) * delta
	var new_dir = rear_pos.direction_to(front_pos)
	
	# Check for slipping / drifting
	if(not drifting and velocity.length() > slip_speed):
		drifting = true
	if(drifting and velocity.length() < slip_speed and current_steering == 0):
		drifting = false

	var traction = traction_fast if drifting else traction_slow
	var new_velocity: Vector3
	var dot = new_dir.dot(velocity.normalized())
	
	if(dot > 0): # forward
		new_velocity = new_dir * min(velocity.length(), max_speed)
	if(dot < 0): # backward
		new_velocity = -new_dir * min(velocity.length(), max_reverse_speed)	
	
	velocity = lerp(velocity, new_velocity, traction)

	body.look_at(body.get_global_transform().origin + new_dir, body.transform.basis.y)
	
