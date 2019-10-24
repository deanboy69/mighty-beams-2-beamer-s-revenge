extends "res://scripts/human.gd"

onready var parent = get_parent()

export (float) var turn_speed
export (int) var detect_radius

var target = null
var target_dir = Vector2()
var target_dist = Vector2()
var current_dir = Vector2()
var move_backward = false


func _ready():
	speed = 0
	$detect_radius/CollisionShape2D.shape.radius = detect_radius
	
	
func control(delta):
	if target:
		target_dir = (target.global_position - global_position).normalized()
		target_dist = global_position.distance_to(target.global_position)
		current_dir = Vector2(1,0).rotated(rotation)
		rotation = current_dir.linear_interpolate(target_dir,turn_speed*delta).angle()
		if not $body/melee_range.is_colliding():
			speed = lerp(speed,max_speed,0.1)
		elif $body/melee_range.is_colliding():
			if not $body/too_close.is_colliding():
				speed = 0
				swing('C1')
			elif $body/too_close.is_colliding():
				speed = max_speed#lerp(speed,max_speed,0.1)
				move_backward = true
				$moveback_timer.start()
	else:
		pass


func _process(delta):
	if alive:
		if move_backward == true:
			velocity = -Vector2(speed, 0).rotated(rotation)
		elif move_backward == false:
			velocity = Vector2(speed, 0).rotated(rotation)
	else:
		velocity = Vector2(0,0)
		die2()
		

func die2():
	target = null
	$detect_radius/CollisionShape2D.set_disabled(true)
	
	
	
func attack_mode():
	pass	
	
	
func _on_detect_radius_body_entered(body):
	target = body
	print(body)

func _on_detect_radius_body_exited(body):
	
	if body == target:
		target = null

func _on_moveback_timer_timeout():
	move_backward = false
