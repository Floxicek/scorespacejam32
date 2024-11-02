extends RigidBody2D


enum Layers 
{
	PLATFORM = 2,
	SAND = 4
}

@export var max_power: float = 1500
@export var power_speed: float = 1000
@export var angle_speed: float = 1

# map of angular dampening values for each layer
@export var layer_damp: Dictionary = {
	Layers.PLATFORM: 3,
	Layers.SAND: 15
}

var power: float = 0
var angle: float = 0

var reset_state = false
var moveVector: Vector2
var spawn_pos
var on_ground = false

func _ready() -> void:
	self.contact_monitor = true
	self.max_contacts_reported = 10
	spawn_pos = global_position

func _integrate_forces(state):
	if reset_state:
		state.transform = Transform2D(0.0, moveVector)
		linear_velocity = Vector2.ZERO
		reset_state = false

	on_ground = false
	for i in range(state.get_contact_count()):
		var contact_normal = state.get_contact_local_normal(i)
		if contact_normal.y < -0.7:  # Check if the normal points upwards
			on_ground = true
			break




func reset_position():
	moveVector = spawn_pos;
	reset_state = true;

func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		angle -= angle_speed * _delta
	if Input.is_action_pressed("ui_right"):
		angle += angle_speed * _delta
	angle = clamp(angle, -1.5, 1.5)

	if not on_ground:
		power = 0
		return

	if Input.is_action_pressed("ui_accept"):
		power += power_speed * _delta
		power = clamp(power, 0, max_power)
	if Input.is_action_just_released("ui_accept") or power >= max_power:
		self.apply_impulse(Vector2.UP.rotated(angle) * power)
		power = 0
		%UI.add_stroke()
	
	$ProgressBar.value = power / max_power * 100

func _physics_process(_delta):
	$Arrow.rotation = angle - self.rotation
	$ProgressBar.rotation = - self.rotation


func _on_body_entered(body: Node) -> void:
	if body.get_parent().name != "Environment":
		return

	var body_layers = body.get_collision_layer()
	for layer in layer_damp.keys():
		if body_layers & layer:
			self.angular_damp = layer_damp[layer]
			break
