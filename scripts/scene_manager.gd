extends Node

@export var scenes : Array[PackedScene]= []


func new_scene(index):
	get_tree().change_scene_to_packed(scenes[0])
