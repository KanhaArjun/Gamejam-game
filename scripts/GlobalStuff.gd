extends Node
# The persistent variable for the total death count (renamed for clarity/style)
var total_deaths = 0
var flag=0
# Function to be called from the player/level script upon death
func add_deaths():
	# 1. Increment the persistent count
	total_deaths += 1
	
	# 2. Print for debugging (optional, but helpful)
	print("X", total_deaths)
	
	# NOTE: The GameManager does NOT update the Label directly.
	# The Label's script (e.g., in your HUD) will read this variable every frame.
