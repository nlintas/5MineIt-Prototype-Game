extends RigidBody2D

# * Attributes *
var explosion = preload("res://entities/explosion.tscn")
	
export var speed: float = 500

# * Methods *
func bang():
	set_use_custom_integrator(true)
	var bang = explosion.instance()
	bang.global_position = global_position
	get_tree().get_root().call_deferred("add_child",bang)
	queue_free()

func _on_bomb_body_entered(_body):
	bang()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
