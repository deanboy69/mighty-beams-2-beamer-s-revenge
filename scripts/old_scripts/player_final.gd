extends RigidBody2D


#speed
var linear_speed = 200
var velocity = Vector2()
var angular_speed = 3
var rotation_dir = 0

#health & attack
var max_health = 30
var health
var damage = 10


#miscellaneous
var targeted_max = false


slave var slave_position = Vector2()
slave var slave_rotation = 0

signal health_changed

func _ready():
	$animation_player.queue('combat_mode')
	health = max_health
	emit_signal('health_changed', health*100/max_health)
	
func _process(delta):
	pass
	
func _physics_process(delta):
	if is_network_master():
		control()
		set_linear_velocity(velocity.rotated(rotation))
		set_angular_velocity(rotation_dir*angular_speed)
		rset_unreliable("slave_position",position)
		rset_unreliable("slave_rotation",rotation)
	else:
		position = slave_position
		rotation = slave_rotation

func control():
	velocity = Vector2()
	rotation_dir = 0
	if Input.is_action_pressed('move_forward'):
		velocity = Vector2(linear_speed,0)
	if Input.is_action_pressed('move_backward'):
		velocity = Vector2(-linear_speed/2,0)
	if Input.is_action_pressed('turn_right'):
		rotation_dir += 1
	if Input.is_action_pressed('turn_left'):
		rotation_dir -= 1
	if Input.is_action_pressed('move_right'):
		velocity = Vector2(0,linear_speed/2)
	if Input.is_action_pressed('move_left'):
		velocity = Vector2(0,-linear_speed/2)	
	if velocity != Vector2(0,0):
		$head_sprite.play()
	else:
		$head_sprite.stop()
	if Input.is_action_just_pressed('left_mouse_button'):
		$animation_player.play('sword_swing_right')
		$animation_player.queue('combat_mode')
	

