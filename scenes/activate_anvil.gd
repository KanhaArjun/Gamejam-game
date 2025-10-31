extends CollisionShape2D
@onready var anv = $"../../Anvil"
@onready var sprite = $"../../Anvil/Sprite2D"

@onready var anv2 = $"../../Anvil2"
@onready var sprite2 = $"../../Anvil2/Sprite2D"
@onready var collider2 = $"../../Anvil2/Deadzone/Area2D/CollisionShape2D"

@onready var anv3 = $"../../Anvil3"
@onready var sprite3 = $"../../Anvil3/Sprite2D"

@onready var timer = $Timer
@onready var timer2 = $Timer2
@onready var timer3 = $Timer3
func _on_area_2d_body_entered(body):
	sprite.visible=true
	
	anv.gravity_scale=1.5
	timer.start()
	timer2.start()
	timer3.start()

func _on_timer_timeout():
	sprite2.visible=true
	anv2.gravity_scale=1.5


func _on_timer_2_timeout():
	sprite3.visible=true
	anv3.gravity_scale=1.5

func _on_timer_3_timeout():
	collider2.disabled=true
