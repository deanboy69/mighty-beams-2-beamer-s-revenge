extends Node2D






func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_WHEEL_UP:
				
				
				if $Camera2D.zoom.length() >= 1.41:
					$CanvasLayer/LensEffect/AnimationPlayer.play("zoom_in")
					$Camera2D.zoom.x -= .5
					$Camera2D.zoom.y -= .5
			if event.button_index == BUTTON_WHEEL_DOWN:

				if $Camera2D.zoom.length() <= 8.48:
					$CanvasLayer/LensEffect/AnimationPlayer.play("zoom_out")
					$Camera2D.zoom.x += .5
					$Camera2D.zoom.y += .5