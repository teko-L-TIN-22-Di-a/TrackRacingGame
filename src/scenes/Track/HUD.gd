extends CanvasLayer

# Countdown
export (int) var minutes = 0
export (int) var seconds = 0

var dsec = 0
var delta = 5

signal start_game

func show_message(text):
	$Control/Message.text = text
	$Control/Message.show()

func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	yield($Control/Timer, "timeout")

	$Control/Message.text = "Ready?"
	$Control/Message.show()
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(5), "timeout")
	$Control/StartButton.show()

func _on_GameTimer_timeout():
	get_tree().change_scene("res://src/scenes/Menu/menu.tscn")


func _on_StartButton_pressed():
	$Control/StartButton.hide()
	$Control/Message.hide()
	emit_signal("start_game")

func _physics_process(delta):
	if dsec >= 0:
		dsec -=1
	if seconds > 0 and dsec <= 0 :
		seconds -=1
		dsec = 10
	if minutes > 0 and seconds <=0:
		minutes -= 1
		seconds = 60
		
	if seconds >= 10:
		$Control/sec.set_text(str(seconds))
	else:
		$Control/sec.set_text("0"+str(seconds))	
	if dsec >= 10:
		$Control/sec.set_text(str(dsec))
	else:
		$Control/sec.set_text("0"+str(dsec))
