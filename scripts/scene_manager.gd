extends Node

@export var scenes : Array[PackedScene]= []
@export var menu_scene: PackedScene
var current_level = 0

func new_scene(index):
	get_tree().change_scene_to_packed(scenes[index])
	current_level = index

func menu():
	get_tree().change_scene_to_packed(menu_scene)
	current_level = -1
