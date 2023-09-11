class_name Hud
extends CanvasLayer

onready var timer_label: Label = $'Control/CenterContainer/TimerLabel'
onready var message_label: Label = $'Control/CenterContainer2/MessageLabel'
onready var score_board: VBoxContainer = $'Control/ScoreBoard'

func show_message(text: String) -> void:
	message_label.text = text
	message_label.show()
	
func hide_message() -> void:
	message_label.hide()

func update_timer(unix_time: int) -> void:
	timer_label.show()
	timer_label.text = _unix_time_to_string(unix_time)

func hide_timer() -> void:
	timer_label.hide()

func add_time(unix_time: int) -> void:
	var new_label = Label.new()
	new_label.text = _unix_time_to_string(unix_time)
	score_board.add_child(new_label)
	score_board.move_child(new_label, 0)

func _unix_time_to_string(unix_time: int) -> String:
	var minutes = unix_time / 60
	var seconds = unix_time % 60
	return "%02d : %02d" % [minutes, seconds]
