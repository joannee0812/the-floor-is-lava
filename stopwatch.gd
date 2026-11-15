extends Node
class_name stopwatch

var time=0.0
var stopped=false

func _process(delta):
	if stopped:
		return
	time+=delta

func reset():
	time=0.0
