extends Area2D

func _on_body_entered(body):
	if body.is_in_group("Player"):
		print("Winnniiing")
		# Play win animation
		# Maybe show some fireworks...
		# End score
		print("Finished with score of: " + str(%UI.stroke_count))
		SilentWolf.Scores.save_score("Chebuk Debug", %UI.stroke_count)
