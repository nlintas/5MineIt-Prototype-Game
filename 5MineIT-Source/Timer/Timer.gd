extends Node2D

# * Attributes *
const continue_scene = preload("res://ContinueNextDay/ContinueDay.tscn")

var timer
var time = 300
var player_node

# * System Callback Methods *
func _ready():
	timer = $Countdown
	timer.wait_time = time
	timer.start()
	timer.set_paused(true)
	player_node = timer.get_parent().get_parent().get_parent().get_node("Player").duplicate()
	
func _process(_delta):
	GlobalVariables.world.get_node("CanvasLayer").get_node("TimeCounter").get_node("CounterNumber").text = str(int(timer.time_left))
	if timer.time_left <= 0:
		GlobalVariables.world.queue_free()
		GlobalVariables.player_node = self.player_node.duplicate()
		get_tree().get_root().add_child(continue_scene.instance())

# * Methods *
func reduce_time(seconds):
	
	var newTime = timer.time_left - seconds
	
	if newTime <= 0:
		GlobalVariables.world.queue_free()
		GlobalVariables.player_node = self.player_node.duplicate()
		get_tree().get_root().add_child(continue_scene.instance())
	else:
		timer.set_wait_time(timer.time_left - seconds)
		timer.start()
	
func pause_timer():
	timer.set_paused(true)
	
func start_timer():
	timer.set_paused(false)
