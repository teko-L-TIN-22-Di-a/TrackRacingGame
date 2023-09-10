class_name State
extends Node

signal transition_request(target_state_path, msg)

func handle_input(event: InputEvent) -> void:
	pass

func update(delta: float) -> void:
	pass

func physics_update(delta: float) -> void:
	pass
	
func enter(msg: Dictionary = {}) -> void:
	pass

func exit() -> void:
	pass

func transition_to(target_state_path: String, msg: Dictionary = {}) -> void:
	emit_signal("transition_request", target_state_path, msg)
