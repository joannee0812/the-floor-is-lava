extends Area2D

signal vector_created(vector)
# Called when the node enters the scene tree for the first time.

@export var MAXIMUM_LENGTH := 200

var touched_down = false
var position_start := Vector2.ZERO
var position_end := Vector2.ZERO

var res_vector := Vector2.ZERO

func _ready() -> void:
	input_event.connect(_on_input_event)
	print("VectorCreator ready")
	input_event.connect(_on_input_event)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#TODO
	
func _input(event)	-> void:
	
	if not touched_down:
		return
	
	if event.is_action_released("ui_touch"):
		touched_down = false
		vector_created.emit(res_vector)
		res_vector = Vector2.ZERO
		queue_redraw()
		return
	
	if event is InputEventMouseMotion:
		position_end = get_global_mouse_position()
		res_vector = (position_end - position_start).limit_length(MAXIMUM_LENGTH)
		queue_redraw()
	

func _on_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if event.is_action_pressed("ui_touch"):
		touched_down = true
		position_start = get_global_mouse_position()
		res_vector = Vector2.ZERO
		
		print("pressed")
		
func _draw() -> void:
	
	if not touched_down:
		return
	draw_line(to_local(position_start), to_local(position_start + res_vector), Color.BLUE, 8)
	
		
