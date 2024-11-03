extends Line2D


@export var player: RigidBody2D
@export var max_length: int = 120
@export var ball_size:= 0.01

@onready var curve := Curve2D.new()

func trail():
	curve.add_point(player.global_position - player.linear_velocity * ball_size)
	if curve.get_baked_points().size() > max_length:
		curve.remove_point(0)
	
	points = curve.get_baked_points()


func _physics_process(_delta):
	trail()
