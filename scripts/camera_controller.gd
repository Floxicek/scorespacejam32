extends Camera2D

@export var player: Node2D
@export var follow_speed:= 5

func _physics_process(delta):
	if player:
		var target_pos = player.global_position
		target_pos.x = 0
		
		global_position = lerp(global_position, target_pos, delta * follow_speed)
