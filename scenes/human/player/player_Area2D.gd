extends "res://scenes/human/human_Area2D.gd"

onready var global = get_node("/root/global_variables")
onready var player_camera = $player_camera

var desired_x


func init(spd,rot,hlth,dmg):
	linear_speed = spd
	rotation_speed = rot
	max_health = hlth
	damage = dmg

func _ready():
	pass
	#init(100,3,40,10)
	
func _process(delta):
	pass
	

func control(delta):
	#MOVEMENT
	velocity = Vector2()
	rotation_dir = 0
	#if $player_camera.is_current():
	if Input.is_action_pressed('move_forward'):
#			desired_x = linear_speed*rotation_dir - velocity.x
#			velocity = Vector2(clamp(desired_x,-linear_acc,linear_acc),0).rotated(rotation)
		velocity = Vector2(linear_speed,0).rotated(rotation)
	if Input.is_action_pressed('move_backward'):
		velocity = Vector2(-linear_speed/2,0).rotated(rotation)
	if Input.is_action_pressed('turn_right'):
		if Input.is_action_pressed('toggle_shifting'):
			movement_type = 'shiftingR'
			velocity = Vector2(0,linear_speed/2).rotated(rotation)
		else:
			movement_type = 'normal'
			rotation_dir += 1
	if Input.is_action_pressed('turn_left'):
		if Input.is_action_pressed('toggle_shifting'):
			movement_type = 'shiftingL'
			velocity = Vector2(0,-linear_speed/2).rotated(rotation)
		else:
			movement_type = 'normal'
			rotation_dir -= 1
	rotation += rotation_speed*rotation_dir*delta
	
	#COMBAT
	if Input.is_action_just_released('left_mouse_button'):
		if blocking == false:
			if velocity == Vector2(0,0):
				if Input.is_action_pressed('attack_left'):
					swing('L1')
				elif Input.is_action_pressed('attack_right'):
					swing('R1')
				else:
					swing('C1')
			else:
				swing('W1')
		else:
			stab()
	if Input.is_action_just_pressed('right_mouse_button'):
		block()
	if Input.is_action_just_released('right_mouse_button'):
		shield_return()