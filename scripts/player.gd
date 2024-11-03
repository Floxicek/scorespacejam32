extends RigidBody2D


@export var max_power: float = 1500
@export var power_speed: float = 1000
@export var angle_speed: float = 1.5

# map of angular dampening values for each layer
@export var layer_damp := [4, 18]

@export var movement_threshold := 3.0

var power: float = 0
var angle: float = 0

var reset_state = false
var moveVector: Vector2
var spawn_pos

var tile_map

func _ready() -> void:
	self.contact_monitor = true
	self.max_contacts_reported = 10
	spawn_pos = global_position
	tile_map = get_parent().tilemap


func _integrate_forces(state):
	if reset_state:
		state.transform = Transform2D(0.0, moveVector)
		linear_velocity = Vector2.ZERO
		reset_state = false

func reset_position():
	moveVector = spawn_pos;
	reset_state = true;

func _process(_delta: float) -> void:
	if Input.is_action_pressed("aim_left"):
		angle -= angle_speed * _delta
	if Input.is_action_pressed("aim_right"):
		angle += angle_speed * _delta
	angle = clamp(angle, -1.5, 1.5)
	
	var tile_pos = tile_map.local_to_map(global_position + Vector2.DOWN)
	var tile_id = tile_map.get_cell_source_id(tile_pos)
	
	if tile_id >= 0:
		self.angular_damp = layer_damp[tile_id]
		

	var is_moving = linear_velocity.length() >= movement_threshold
	if is_moving:
		#$Arrow.default_color = Color(255,255,255,.3)
		#$Arrow.gradient.colors[0] = Color(255,255,255,.3)
		change_arrow_color(.3)
		power = 0
		$ProgressBar.value = power / max_power * 100
		return

	#$Arrow.gradient.colors[0] = Color.WHITE
	
	change_arrow_color(1)
	if Input.is_action_pressed("ui_accept"):
		power += power_speed * _delta
		power = clamp(power, 0, max_power)
	if Input.is_action_just_released("ui_accept") or power >= max_power:
		self.apply_impulse(Vector2.UP.rotated(angle) * power)
		power = 0
		Score.add_stroke()
	
	$ProgressBar.value = power / max_power * 100

func _physics_process(_delta):
	$Arrow.rotation = angle - self.rotation
	$ProgressBar.rotation = - self.rotation



func change_arrow_color(alpha: float):
	var tween := get_tree().create_tween()
	tween.tween_property($Arrow/Arrow, "self_modulate:a", alpha, .3)


#func _on_body_entered(body: Node) -> void:
	#if not body.is_in_group("Platform"):
		#return
#
	#var body_layers = body.get_collision_layer()
	#print(body_layers)
	#for layer in layer_damp.keys():
		#if body_layers & layer:
			#self.angular_damp = layer_damp[layer]
			#print(layer_damp[layer])
			#break
