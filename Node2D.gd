extends KinematicBody2D


export var selected = false
onready var selectBox = $selectBox



func _on_Node2D_input_event(viewport, event, shape_idx):
	print('asfasdfsd')
	if event is InputEventMouseButton:
		if event.is_pressed():
			print('asdf')
			if event.button_index == BUTTON_LEFT:
				selected = true
			if event.button_index == BUTTON_RIGHT:
				selected = false

