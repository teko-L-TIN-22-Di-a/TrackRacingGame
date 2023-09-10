extends PlayerState

func update(delta: float) -> void:
	
	if(player.body.is_on_floor()):
		transition_to("Idle")
		return
	

func exit() -> void:
	player.acceleration.y = 0
