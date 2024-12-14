extends CharacterBody3D

@export var move_speed: float = 5.0  # Player movement speed
@export var look_sensitivity: float = 0.4  # Camera rotation sensitivity

var camera_rotation: Vector2 = Vector2.ZERO  # Camera rotation (yaw, pitch)
var camera: Camera3D  # Reference to the camera node

func _ready():
	# Initialize camera
	camera = $Camera3D  # Assuming Camera3D is a child of this node

func _process(delta):
	handle_input(delta)
	update_camera_rotation()

# Handle WASD movement
func handle_input(delta: float):
	var input_dir = Vector3.ZERO

	if Input.is_action_pressed("move_forward"):  # W
		input_dir.z += 1
	if Input.is_action_pressed("move_backward"):  # S
		input_dir.z -= 1
	if Input.is_action_pressed("move_left"):  # A
		input_dir.x -= 1
	if Input.is_action_pressed("move_right"):  # D
		input_dir.x += 1

	# Normalize direction and transform it to global space
	input_dir = input_dir.normalized()
	var global_direction = (input_dir.x * global_transform.basis.x + input_dir.z * -global_transform.basis.z) * move_speed

	# Apply movement
	velocity.x = global_direction.x
	velocity.z = global_direction.z

	move_and_slide()

# Update camera rotation
func update_camera_rotation():
	# Arrow keys for looking around
	if Input.is_action_pressed("look_left"):  # Left Arrow
		camera_rotation.x += look_sensitivity
	if Input.is_action_pressed("look_right"):  # Right Arrow
		camera_rotation.x -= look_sensitivity
	if Input.is_action_pressed("look_up"):  # Up Arrow
		camera_rotation.y = clamp(camera_rotation.y + look_sensitivity, -90, 90)
	if Input.is_action_pressed("look_down"):  # Down Arrow
		camera_rotation.y = clamp(camera_rotation.y - look_sensitivity, -90, 90)

	# Update player rotation (yaw)
	rotation_degrees.y = camera_rotation.x

	# Update camera rotation (pitch)
	camera.rotation_degrees.x = camera_rotation.y
