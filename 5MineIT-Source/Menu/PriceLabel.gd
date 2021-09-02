extends Label

# * Attributes *
export(int) var price

# * System Callback Methods *
func _ready():
	text = str(price)
