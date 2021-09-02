extends Area2D

# * Methods *
func _on_ShopArea_body_entered(_body):
	GlobalVariables.inShop = true;

func _on_ShopArea_body_exited(_body):
	GlobalVariables.inShop = false;
