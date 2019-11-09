extends Node2D

var startPos = Vector2()
var endPos = Vector2()

var move = false
var rotate = false
var selected = false


onready var state = $AnimationPlayer


func _ready():
	visible = false
	state.play('default')
	
	
func _process(delta):
	if selected:
		rotate_and_change_width()
		move_unit()

#	disable_shapes()

func transform_organizer(startPos,endPos):
	#position = startPos
	rotation = (startPos - endPos).angle() + deg2rad(90)
	visible = true
	
	
func rotate_and_change_width():	
	if rotate == true:
		if Input.is_action_just_pressed('right_mouse_button'):
			visible = false
			startPos = position
			$display_timer.start()
		if Input.is_action_just_released('right_mouse_button'):
			pass#visible = false
		change_unit_width()
	
func move_unit():
	if move == true:
		if Input.is_action_just_pressed('right_mouse_button'):
			position = get_global_mouse_position()
	
func change_unit_width():
	if Input.is_action_pressed('right_mouse_button'):
		var dist = (startPos - get_global_mouse_position()).length()
		if dist > 333:
			state.play("width_10")
		if 333 >= dist and dist > 222:
			state.play("width_8")
		if 222 >= dist and dist > 148:
			state.play("width_6")
		if 148 >= dist and dist > 74:
			state.play("width_4")
		if 74 >= dist:
			state.play("width_2")
			
#func disable_shapes():
#	if state.is_playing("width_10"):
#		pass
#	if state.


func _on_display_timer_timeout():
	endPos = get_global_mouse_position()
	transform_organizer(startPos,endPos)
	
