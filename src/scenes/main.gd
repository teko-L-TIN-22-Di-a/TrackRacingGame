extends Node

# Entry Point
export var start_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(start_scene.instance())


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
