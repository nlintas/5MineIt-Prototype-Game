extends NinePatchRect

# * Custom Methods *
# Update the counter of bombs when a player uses them.
func updateCounter(newbombs):
	$CounterNumber.text = str(int(newbombs))
