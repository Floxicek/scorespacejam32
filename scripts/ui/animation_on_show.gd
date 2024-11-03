class_name AnimationOnShow extends Node

@export var transition_type := Tween.TransitionType.TRANS_QUAD
@export var hidden_height := 1200
@export var duration := .7

@onready var target: Control
var default_position: Vector2

func _ready():
	target = get_parent()
	target.visibility_changed.connect(animation_on_show.bind())
	
	default_position = target.position
	target.position = default_position + Vector2.DOWN * hidden_height

func animation_on_show():
	print("Animating")
	add_tween("position", default_position, duration)

func add_tween(property: String, value, seconds: float) -> void:
	if not is_inside_tree():
		return
	var tween = get_tree().create_tween()
	tween.tween_property(target, property, value, seconds).set_trans(transition_type)
