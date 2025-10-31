extends CollisionShape2D
@onready var Grnd = $"../../AnimatableBody2D/AnimationPlayer"
var flag = 0
func _on_move_ground_body_entered(body):
	if(flag==0):
		flag=1
		Grnd.play("Moveth")
