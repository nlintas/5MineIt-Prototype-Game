extends NinePatchRect

# * System Callback Methods *
func _ready():
	updateCounter()
	
# * Methods *
# Update the counter of bombs when a player uses them.
func updateCounter():
	$CounterNumber.text = str(GlobalVariables.money)
