extends CollisionShape2D
@onready var Grnd = $"../../Moving ground left/AnimationPlayer"
@onready var anv =$"../../Anvil4"
@onready var sprite = $"../../Anvil4/Sprite2D"
@onready var anv2 =$"../../Anvil5"
@onready var sprite2 = $"../../Anvil5/Sprite2D"
@onready var timer = $Timer
@onready var timer2 = $Timer2
var flag = 0
func _on_move_ground_body_entered(body):
	if(flag==0):
		flag=1
		Grnd.play("Moveth")
	timer.start()
	timer2.start()


func _on_timer_timeout():
	sprite.visible=true
	anv.gravity_scale=1.5


func _on_timer_2_timeout():
	sprite2.visible=true
	anv2.gravity_scale=1.5
