extends Area2D

# * Attributes *
var timer
var canvas
var hat_time_reduction = 0

# * System Callback Methods *
func _ready():
	canvas = get_tree().get_root().get_node("World").get_node("CanvasLayer")
	timer = get_tree().get_root().get_node("World").get_node("CanvasLayer").get_node("Timer")

func _on_Area2D_body_entered(_body):
	canvas = GlobalVariables.world.get_node("CanvasLayer")
	timer = GlobalVariables.world.get_node("CanvasLayer").get_node("Timer")
	if timer != null:
		if(GlobalVariables.upgrades["Hat"] > 1):
			hat_time_reduction = 40 * (1 - GlobalVariables.upgrades["Hat"]) * 0.20
		timer.reduce_time(40 + hat_time_reduction)
