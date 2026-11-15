extends CanvasLayer

@onready var timer_label: Label = $Label
@export var death_screen_scene: PackedScene = preload("res://YouDied.tscn")

var is_dead = false

@export var start_time: float = 120.0  # seconds
var time_left: float = 0.0
var running := true


func _ready() -> void:
	timer_label.position = Vector2(20, 20)
	timer_label.add_theme_font_size_override("font_size", 32)
	print("Timer UI loaded")
	time_left = start_time
	_update_label()
	


func _process(delta: float) -> void:
	if not running:
		return

	time_left -= delta
	if time_left <= 0.0:
		time_left = 0.0
		running = false
		time_up()

	_update_label()


func _update_label() -> void:
	var total := ceili(time_left)
	timer_label.text = "%02d:%02d" % [total / 60, total % 60]


func time_up() -> void:
	print("Time's up!")
	 # game over logic goes here
	var death_screen = death_screen_scene.instantiate()
	get_tree().current_scene.add_child(death_screen)
