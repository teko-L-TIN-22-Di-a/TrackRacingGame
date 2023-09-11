extends Camera

export var target_path: NodePath
export var vertical_distance: float = 4
export var height: float = 5
export var over_player: float = 0.45
export var fixed_angle: float = 0.56

onready var target: Node = get_node(target_path)

var _position := transform.origin

func _process(delta):
	if (not target): return
	
	var target_pos = target.get_global_transform().origin
	target_pos.y += over_player
	
	var target_rotation = (-target.transform.basis.z).normalized()
	
	var camera_pos = target_pos - (target_rotation * vertical_distance)
	camera_pos.y += height

	_position = lerp(_position, camera_pos, delta)

	look_at_from_position(camera_pos, target_pos, Vector3.UP)
	rotate(transform.basis.x.normalized(), fixed_angle)
