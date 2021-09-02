extends Area2D

# * Attributes *
var flag = false
func _on_sapphire_body_entered(body):
	if not flag && body.is_in_group("player"):
		$AnimationPlayer.play("bounce")
		body.add_sapphire()
		flag = true

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
