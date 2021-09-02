extends RigidBody2D

# * Attributes *
var tilemap;
var oremap
export (int) var explosion_size = 32

# * System Callback Methods *
func _ready():
	$CollisionShape2D.shape.radius = explosion_size / 2
	$AnimationPlayer.play("explode")
	tilemap =  GlobalVariables.world.get_node("destructable")
	oremap =  GlobalVariables.world.get_node("ores")

# * Methods *
func _integrate_forces(state):
	
	for i in range(state.get_contact_count()):
		if(state.get_contact_collider_object(i) != null):
			if state.get_contact_collider_object(i).is_in_group("destructable") && tilemap!=null:
				var hit = tilemap.world_to_map(state.get_contact_local_position(i))
				tilemap.replace_tile(hit)
			if state.get_contact_collider_object(i).is_in_group("ores") && oremap!=null:
				var hit = oremap.world_to_map(state.get_contact_local_position(i))
				oremap.replace_tile(hit, self.get_instance_id(), state.get_contact_local_position(i))
			

func _on_AnimationPlayer_animation_finished(_anim_name):
	queue_free()
