extends Node

@export var scenes : Array[PackedScene]= []
var current_level = 0

func new_scene(index):
	get_tree().change_scene_to_packed(scenes[index])
	current_level = index
