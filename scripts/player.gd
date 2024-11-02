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

func _ready() -> void:
	self.contact_monitor = true
	self.max_contacts_reported = 10


var reset_state = false
var moveVector: Vector2

func _integrate_forces(state):
	if reset_state:
		state.transform = Transform2D(0.0, moveVector)
		reset_state = false

func move_body(targetPos: Vector2):
	moveVector = targetPos;
	reset_state = true;

func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_left"):
		angle -= angle_speed * _delta
	if Input.is_action_pressed("ui_right"):
		angle += angle_speed * _delta
	angle = clamp(angle, -1.5, 1.5)

	if Input.is_action_pressed("ui_accept"):
		power += power_speed * _delta
		power = clamp(power, 0, max_power)
	if Input.is_action_just_released("ui_accept") or power >= max_power:
		self.apply_impulse(Vector2.UP.rotated(angle) * power)
		power = 0
		%UI.add_stroke()
	
	$ProgressBar.value = power / max_power * 100

func _physics_process(delta):
	$Arrow.rotation = angle - self.rotation
	$ProgressBar.rotation = -self.rotation


func _on_body_entered(body: Node) -> void:
	if body.get_parent().name != "Environment":
		return

	var body_layers = body.get_collision_layer()
	for layer in layer_damp.keys():
		if body_layers & layer:
			self.angular_damp = layer_damp[layer]
			break
