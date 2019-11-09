extends Camera2D



var zoom_step = 1.1
var min_zoom = 0.5
var max_zoom = 2.0

var pan_speed = 100

var panning = Vector2()
var mouse_captured

var mouse_start = Vector2()
var mouse_end = Vector2()
var mouse_diff = Vector2()


func _input(event):
	if event is InputEventMouseButton:
		if event.is_action_pressed('zoom_in'):
			if mouse_captured == false:
				if zoom.length() >= .089:
					#$CanvasLayer/LensEffect/AnimationPlayer.play("zoom_in")
					zoom.x *= .5
					zoom.y *= .5
					var current_pos = position
					set_position(get_global_mouse_position())
		if event.is_action_pressed('zoom_out'):
			if mouse_captured == false:
				if zoom.length() <= .35:
					#$CanvasLayer/LensEffect/AnimationPlayer.play("zoom_out")
					zoom.x *= 2
					zoom.y *= 2
					print(zoom)
					var current_pos = position
					set_position(get_global_mouse_position())
			
		if event.is_action_pressed('pan'):
			mouse_captured = true
		if event.is_action_released('pan'):
			mouse_captured = false

func _process(delta):
	
	if Input.is_action_just_pressed('pan'):
		mouse_captured = true
		mouse_start = get_global_mouse_position()
	if Input.is_action_just_released('pan'):
		mouse_captured = false
		mouse_start = Vector2(0,0)
	if mouse_captured == true:
		if InputEventMouseMotion:
			mouse_end = get_global_mouse_position()
			mouse_diff = mouse_start - mouse_end
		print(mouse_diff.length())
		#if mouse_diff.length() > 5:

		position += mouse_diff * pan_speed * delta * zoom

			
			
			
			



#func _input(event):
#	if event is InputEventMouseButton:
#		if event.is_pressed() and not event.is_echo():
#			if event.button_index == BUTTON_WHEEL_UP:
#				var old_pos = get_position()
#				set_position(get_global_mouse_position()) 
#				set_offset(  old_pos - get_global_mouse_position()  + get_offset() )
#
#				var zoom_ani = get_node("AnimationPlayer").get_animation( "zoom" )
#				zoom_ani.track_set_key_value(0,0,get_zoom() )
#				zoom_ani.track_set_key_value(0,1,get_zoom()*0.8 )
#
#				zoom_ani.track_set_key_value(1,0,get_offset() )
#				zoom_ani.track_set_key_value(1,1, Vector2(0,0) )
#				get_node("AnimationPlayer").play("zoom")
#		if event.button_index == BUTTON_WHEEL_DOWN:
#				var old_pos = get_position()
#				set_position(get_global_mouse_position()) 
#				set_offset(  old_pos - get_global_mouse_position()  + get_offset() )
#
#				var zoom_ani = get_node("AnimationPlayer").get_animation( "zoom" )
#				zoom_ani.track_set_key_value(0,0,get_zoom() )
#				zoom_ani.track_set_key_value(0,1,get_zoom()/0.8 )
#
#				zoom_ani.track_set_key_value(1,0,get_offset() )
#				zoom_ani.track_set_key_value(1,1, Vector2(0,0) )
#				get_node("AnimationPlayer").play("zoom")