extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		var tween = get_tree().create_tween()
		tween.tween_property(%SikeText, "modulate:a", 1, 3).set_trans(Tween.TRANS_SINE)
