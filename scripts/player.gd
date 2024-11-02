extends RigidBody2D


var max_power: float = 1500
var power_speed: float = 1000
var angle_speed: float = 1

var power: float = 0
var angle: float = 0

func _ready() -> void:
	pass


func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		angle -= angle_speed * _delta
	if Input.is_action_pressed("ui_right"):
		angle += angle_speed * _delta
	angle = clamp(angle, -1.3, 1.3)
	$Arrow.rotation = angle - self.rotation

	if Input.is_action_pressed("ui_accept"):
		power += power_speed * _delta
		power = clamp(power, 0, max_power)
	if Input.is_action_just_released("ui_accept") or power >= max_power:
		self.apply_impulse(Vector2.UP.rotated(angle) * power)
		power = 0
		%UI.add_stroke()
	%ProgressBar.value = power / max_power * 100
