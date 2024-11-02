extends TextureProgressBar

@export var player: Node2D


func _process(delta):
	follow_player()


func follow_player():
	global_position = player.global_position - Vector2(16,16)
