extends Label

# This function runs every frame (or you could use a Signal for efficiency)
func _process(delta):
	# Read the global variable from the GameManager Autoload and set the text
	# The 'X' is a prefix, and we use str() to convert the number to a string
	text = "X" + str(GlobalStuff.total_deaths)
