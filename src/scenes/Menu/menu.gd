extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#onready var btn = $'CenterContainer/VBoxContainer/CenterContainer2/Button2'

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_Button_pressed():
	get_tree().quit()


func _on_Button2_pressed():
	get_tree().change_scene("res://src/scenes/Track/track.tscn")