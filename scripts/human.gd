extends KinematicBody2D


#speed & movement
export (int) var linear_speed #= 200
export (int) var collision_weight
var velocity = Vector2()
export (float) var rotation_speed #=3
export (float) var rotation_dir #= 0
var movement_type = 'normal'

#health & attack
export (int) var max_health #= 30
var health
var alive
export (int) var damage #= 10
var blocking = false
var blocked = false


#miscellaneous
var targeted_max = false
var state_machine
var frame0 = preload('res://assets/animation/walking/frame0.png')
var frame1 = preload('res://assets/animation/walking/frame1.png')
var frame2 = preload('res://assets/animation/walking/frame2.png')
var frame3 = preload('res://assets/animation/walking/frame3.png')
var frame4 = preload('res://assets/animation/walking/frame4.png')
var frame5 = preload('res://assets/animation/walking/frame5.png')
var frame6 = preload('res://assets/animation/walking/frame6.png')
var frame7 = preload('res://assets/animation/walking/frame7.png')
var frame8 = preload('res://assets/animation/walking/frame8.png')
var frame9 = preload('res://assets/animation/walking/frame9.png')
var frame10 = preload('res://assets/animation/walking/frame10.png')
var frame11 = preload('res://assets/animation/walking/frame11.png')




signal health_changed






#const MAX_SPEED, ACC
#
#var velocity = Vector2(0,0)
#
#
#func _physics_process
#    var dir = 0
#    if input_left
#        dir -= 1
#    if input_right
#        dir += 1
#    desired_x = MAX_SPEED*dir - velocity.x
#    velocity += Vector2(clamp(desired_x, -ACC, ACC), 0)
#    move_and_slide(velocity)

func _ready():
	health = max_health
	alive = true
	emit_signal('health_changed', health*100/max_health)
	$AnimationTree.set_active(true)
	state_machine = $AnimationTree.get('parameters/playback')
	state_machine.start('idle_shield_1hand')
	$movement.playback_speed = 2
	
func _process(delta):
	pass
	
func _physics_process(delta):
	if alive:
		control(delta)
		move_and_slide(velocity)
		
		if get_slide_count() != 0 :
			print('asdfasdf')
			for i in range (0,get_slide_count()) :
				print(get_slide_collision(i))
		motion()

func die():
	queue_free()


func control(delta):
	pass
	
	
func attack_mode():
	pass	
	
func swing(type):
	if blocked == false:
		if type == str('C1'):
			state_machine.travel('swingC_shield_1hand')
		if type == str('L1'):
			state_machine.travel('swingL_shield_1hand')
		if type == str('R1'):
			state_machine.travel('swingR_shield_1hand')
		if type == str('W1'):
			movement_type = 'swinging'
	else:
		pass
		

func stab():
	state_machine.travel('stab_shield_1hand')
	pass
		


func block():
	state_machine.travel('idle2block_shield_1hand')
	blocking = true
	
func shield_return():
	state_machine.travel('block2idle_shield_1hand')
	blocking = false
	
	
	
func take_damage(amount):
	if alive:
		health -= amount
		emit_signal('health_changed', health*100/max_health)
		if health <= 0:
			die()
	if name == 'player':
		print(health)

	
func motion():
	if velocity != Vector2(0,0):
		if movement_type == 'normal':
			if blocking == false:
				state_machine.travel('walking_shield_1hand')
			$movement.play('walking')
		if movement_type == 'swinging':
			state_machine.travel('swingW_shield_1hand')
			movement_type = 'normal'
		if movement_type == 'shiftingL':
			$movement.play('shiftingL')
		if movement_type == 'shiftingR':
			$movement.play('shiftingR')
	if abs(velocity.x) < 6 and abs(velocity.y) < 6:
		velocity = Vector2(0,0)
		$movement.stop()
		if $body/legs.texture in [frame0,frame5,frame6,frame11]:
			pass
		elif $body/legs.texture in [frame1,frame2,frame3,frame4]:
			$body/legs.texture = frame0
		elif $body/legs.texture in [frame7]:
			$body/legs.texture = frame5
		elif $body/legs.texture in [frame8]:
			$body/legs.texture = frame6
		elif $body/legs.texture in [frame9,frame10]:
			$body/legs.texture = frame11



func _on_vulnerable_area_area_entered(area):
	if area.owner != self:
		take_damage(area.owner.damage)
		print(health)
