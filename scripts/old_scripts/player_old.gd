extends "res://scripts/human.gd"

onready var global = get_node("/root/global_variables")

func _ready():
	speed = max_speed

func control(delta):
	global.player_pos = position
#control movement
	var rot_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed('move_right'):
		rot_dir += 1
	if Input.is_action_pressed('move_left'):
		rot_dir -= 1
	if Input.is_action_pressed('move_backward'):
		velocity = Vector2(-speed/2, 0).rotated(rotation)
	if Input.is_action_pressed('move_forward'):
		velocity = Vector2(speed, 0).rotated(rotation)
	rotation += rotation_speed*rot_dir*delta
#control attacks   TEMPORARY COMMENT OUT WHILE SETTING UP UI
#	if Input.is_action_just_pressed('left_mouse_button'):
#		if blocking == false:
#			$swing_timer.start()
#		elif blocking == true:
#			stab()
#	if Input.is_action_just_released('left_mouse_button'):
#		if blocking == false:
#			if $swing_timer.time_left > 0:
#				swing('C1')
#				$swing_timer.stop()
#	if Input.is_action_just_pressed('right_mouse_button'):
#		block()
#	if Input.is_action_just_released('right_mouse_button'):
#		shield_return()



func attack_mode():
	pass	








func _on_swing_timer_timeout():
	pass
	#swing(1)
