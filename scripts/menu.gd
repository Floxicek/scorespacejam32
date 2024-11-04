extends Control



func _on_tutorial_pressed() -> void:
	SceneManager.new_scene(0)

func _on_level_easy_pressed() -> void:
	SceneManager.new_scene(1)

func _on_level_hard_pressed() -> void:
	SceneManager.new_scene(2)
