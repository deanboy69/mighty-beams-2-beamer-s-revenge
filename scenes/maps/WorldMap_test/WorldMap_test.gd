extends Node2D

#
#onready var camera = $WorldMap_Camera
#onready var lensEffect = $CanvasLayer/LensEffect/AnimationPlayer
#
#
#func _input(event):
#	if event is InputEventMouseButton:
#		if event.is_pressed():
#			if event.button_index == BUTTON_WHEEL_UP:
#				if camera.zoom.length() >= 1.41:
#					lensEffect.play("zoom_in")
#					camera.zoom.x -= .5
#					camera.zoom.y -= .5
#			if event.button_index == BUTTON_WHEEL_DOWN:
#				if camera.zoom.length() <= 8.48:
#					lensEffect.play("zoom_out")
#					camera.zoom.x += .5
#					camera.zoom.y += .5