extends Spatial

onready var player: Player = $'Player'
onready var start_pos: Position3D = $'StartPosition'

onready var hud: Hud = $'HUD'

onready var start_timer: Timer = $'StartTimer'

var countdown: int
var started = false
var start_time: int
var midpoint_reached = false

func _process(delta):
	
	if(!started): 
		player.velocity = Vector3.ZERO
		return
	
	hud.update_timer(OS.get_unix_time() - start_time)

func _ready():
	new_game()

func game_over():
	pass

func new_game():
	player.transform.origin = start_pos.transform.origin
	player.disable()
	
	countdown = 3
	hud.show_message("Ready? \n 3")
	hud.hide_timer()
	start_timer.start()
	
func start_game():
	pass

func _on_StartTimer_timeout():
	
	if(countdown < 0):
		start_game()
		hud.hide_message()
		start_timer.stop()
		player.enable()
		start_time = OS.get_unix_time()
		started = true
		
		return
	
	hud.show_message("Ready? \n %d" % [countdown])
	countdown -= 1


func _on_Finish_body_entered(body: Node):
	if(body.name != "KinematicBody"): # Player
		return
		
	if(!midpoint_reached): return
	
	hud.add_time(OS.get_unix_time() - start_time)
	start_time = OS.get_unix_time()
	midpoint_reached = false

func _on_Midpoint_body_entered(body: Node):
	if(body.name != "KinematicBody"): # Player
		return
		
	midpoint_reached = true
