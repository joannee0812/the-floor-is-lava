extends StaticBody2D

@export var area := Rect2(-500, -300, 1000, 600)   # set to your level's edges
@export var thickness := 100.0

func _ready() -> void:
	var r := area
	var t := thickness
	_add_wall(Rect2(r.position.x - t, r.position.y - t, r.size.x + 2.0 * t, t))   # top
	_add_wall(Rect2(r.position.x - t, r.end.y, r.size.x + 2.0 * t, t))            # bottom
	_add_wall(Rect2(r.position.x - t, r.position.y, t, r.size.y))                 # left
	_add_wall(Rect2(r.end.x, r.position.y, t, r.size.y))   
	print("Boundary Built")
					  # right

func _add_wall(rect: Rect2) -> void:
	var shape := RectangleShape2D.new()
	shape.size = rect.size
	var cs := CollisionShape2D.new()
	cs.shape = shape
	cs.position = rect.get_center()
	add_child(cs)
