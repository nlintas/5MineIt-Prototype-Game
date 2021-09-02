extends Area2D

# * Methods *
func _on_chest_entered(_body):
	get_tree().quit()

func _on_ShopArea_body_exited(_body):
	GlobalVariables.inShop = false;
