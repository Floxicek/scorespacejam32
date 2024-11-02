extends Area2D


func _on_body_entered(body):
	if body.is_in_group("Player"):
		body.move_body(Vector2(0,0))
