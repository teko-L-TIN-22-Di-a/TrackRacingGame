extends Spatial

export var speed: float = 5
export var max_speed: float = 10
export var gravity: float = 8.1
export var terminal_velocity: float = 100

onready var body: KinematicBody = $'KinematicBody'

var velocity = Vector3.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	# TODO Handle Input
	# TODO Handle Animations
	
	if body.is_on_floor():
		velocity.y = clamp(velocity.y - gravity, 0, terminal_velocity)
		
		print_debug(velocity)
	else:
		var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").normalized()
		
		print_debug(velocity)
		
		velocity.x = clamp(velocity.x + direction.x * speed, -max_speed, max_speed)
		velocity.z = clamp(velocity.z + direction.y * speed, -max_speed, max_speed)
	
	body.move_and_slide(velocity * delta, Vector3.UP)
	
