extends PlayerState

func update(delta: float) -> void:
	
	player.acceleration.y = 0
	
	if(not player.body.is_on_floor()):
		transition_to("Air")
		return
	
	var movement = Input.get_vector("turn_left", "turn_right", "down", "up")
	if(
		movement == Vector2.ZERO 
		&& player.velocity.x == 0
		&& player.velocity.z == 0
	):
		transition_to("Idle")
		return
	
	var steer_target = Input.get_action_strength("turn_left") - Input.get_action_strength("turn_right")
	player.current_steering = steer_target * deg2rad(player.steering_limit)
	
	player.acceleration = Vector3.ZERO
	if(Input.is_action_pressed("up")):
		player.acceleration = -player.body.transform.basis.z * player.engine_force
		
	if(Input.is_action_pressed("down")):
		if(player.velocity.z <= 0):
			player.acceleration = -player.body.transform.basis.z * -player.brake_force
		else:
			player.acceleration = -player.body.transform.basis.z * -player.engine_force
	
