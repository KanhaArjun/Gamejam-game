extends Sprite2D
const TEXTURE_PATH = "res://assets/sprites/Dude_Monster.png"
func _ready():
	if(GlobalStuff.total_deaths>5):
		var new_texture = load(TEXTURE_PATH)
		texture = new_texture
