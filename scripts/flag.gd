extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("Winnniiing")
		# Play win animation
		# Maybe show some fireworks...
		# End score
		Score.level_finished()
		get_tree().change_scene_to_file("res://scenes/ui/scoreboard.tscn")
