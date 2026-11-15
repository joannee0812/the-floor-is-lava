extends CharacterBody2D


const SPEED = 50
const JUMP_VELOCITY = -200.0
var MAX_LENGTH := 200

@export var coeff_restit := 0.7
@export var minimum_bounce_speed := 80.0

@onready var lava: TileMapLayer = get_node("../Lava")
var spawn_position: Vector2



var screen_size: Vector2

func _ready() -> void:
	screen_size = get_viewport_rect().size
	$VectorCreator.vector_created.connect(_on_vector_created)
	spawn_position = global_position
	
	
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
	
	var pre_velocity := velocity
	move_and_slide()
	
	for i in get_slide_collision_count():
		var normal := get_slide_collision(i).get_normal()
		var collision := get_slide_collision(i)
		if collision.get_collider() == lava:
			die()
			return
			
		var impact_speed := pre_velocity.dot(-normal)
		if impact_speed > minimum_bounce_speed:
			velocity = pre_velocity.bounce(normal) * coeff_restit
			break
	
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
func die() -> void:
	global_position = spawn_position
	velocity = Vector2.ZERO


		


func _on_timer_timeout() -> void:
	print("Time's up! U lose lol.")
	
