class_name StateHandler
extends Node

signal transitioned(state_name)

export var initial_state: NodePath

onready var state: State = get_node(initial_state)

func transition_to(target_state_path: String, msg: Dictionary = {}) -> void:
	print("Transitioning to ", target_state_path)
	
	if(not has_node(target_state_path)):
		return
	
	if(not state):
		return
	
	state.exit()
	state = get_node(target_state_path)
	state.enter(msg)
	emit_signal("transitioned", state.name)

func _ready():
	for node in get_children():
		var state := node as State
		
		if(not state):
			continue
			
		state.connect("transition_request", self, "_on_transition_request")
	
	if(state):
		state.enter()

func unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)

func process(delta: float) -> void:
	state.update(delta)
	
func physics_process(delta: float) -> void:
	state.physics_update(delta)
	
func _on_transition_request(target_state_path: String, msg: Dictionary = {}):
	transition_to(target_state_path, msg)
