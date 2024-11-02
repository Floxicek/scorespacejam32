extends Camera2D

@export_category("Zoom")
@export var zoom_increment := 0.2
@export var zoom_speed := 0.5
@export var zoom_min := 0.6
@export var zoom_max := 1.5
@export_category("Follow")
@export var player: Node2D
@export var follow_speed:= 3
@export var ignore_height := 0
@export var height_offset := -200

var zoom_target = 1.0

func _process(delta):
	if Input.is_action_just_released("zoom_in"):
		zoom_target += zoom_increment
	elif Input.is_action_just_released("zoom_out"):
		zoom_target -= zoom_increment
	zoom_target = clamp(zoom_target, zoom_min, zoom_max)
	var z = lerp(zoom.x, zoom_target, zoom_increment * delta * 60 * zoom_speed)
	zoom = Vector2(z,z)

func _physics_process(delta):
	if player:
		var target_pos = player.global_position
		target_pos.y = min(target_pos.y, ignore_height) - height_offset
		
		global_position = lerp(global_position, target_pos, delta * follow_speed)
