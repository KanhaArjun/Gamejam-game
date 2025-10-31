extends CollisionShape2D
@onready var Grnd = $"../../Moving ground up/AnimationPlayer"
var flag = 0
func _on_move_ground_up_body_entered(body):
	if(flag==0):
		flag=1
		Grnd.play("Movethup")
