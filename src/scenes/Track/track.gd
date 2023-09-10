extends Spatial

var score

func _ready():
	new_game()

func game_over():
	$ScoreTimer.stop()

func new_game():
	#$Player.start($StartPosition.position)
	$StartTimer.start()

func _on_StartTimer_timeout():
	$ScoreTimer.start()
