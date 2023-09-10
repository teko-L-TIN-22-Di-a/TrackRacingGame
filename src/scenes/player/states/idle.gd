extends PlayerState

func update(delta: float) -> void:
	
	player.acceleration.y = 0
	
	if(not player.body.is_on_floor()):
		transition_to("Air")
		return
	
	var movement = Input.get_vector("turn_left", "turn_right", "down", "up")
	
	if(movement != Vector2.ZERO):
		transition_to("Moving", {"initial_movement": movement})
		return
