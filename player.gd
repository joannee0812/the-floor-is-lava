extends CharacterBody2D


const SPEED = 50
const JUMP_VELOCITY = -200.0
var MAX_LENGTH := 200


var screen_size: Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size
	$VectorCreator.vector_created.connect(_on_vector_created)
	
func _on_vector_created(vector: Vector2) -> void:
	velocity = vector * 2	
	

func _physics_process(delta: float) -> void:
	# Use mouse to pull a vector of scaled magnitude (velocity) and direction
	# delta_r_mouse * k = m(v->)
	# theta_mourse = theta(v->)
	look_at(get_global_mouse_position())
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY
	
	
	
	# SCREEN WRAP

	
	move_and_slide()


#func _physics_process(delta: float) -> void:
	
	'''
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept"):
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	'''



		


func _on_timer_timeout() -> void:
	print("Time's up! U lose lol.")
	
