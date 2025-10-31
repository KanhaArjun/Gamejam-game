extends CollisionShape2D
func _on_a(body):
	if body.is_in_group("Player"):
		body.death()
		Engine.time_scale = 0.5
		timer.start()

func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
