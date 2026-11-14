extends Area2D

signal vector_created(vector)
# Called when the node enters the scene tree for the first time.

@export var MAXIMUM_LENGTH := 200

var position_start := Vector2.ZERO
var position_end := Vector2.ZERO

var vector := Vector2.ZERO

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
