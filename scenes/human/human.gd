extends KinematicBody2D


#speed & movement
var linear_speed #= 200
var collision_weight
var velocity = Vector2()
var rotation_speed #=3
var rotation_dir #= 0
var movement_type = 'normal'

#health & attack
var max_health = 30
var health
var alive
var damage #= 10
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




#debugging
onready var sword_coll = $right/upperArm_R/lowerArm_R/item_R/item_area_R/item_shape_R
onready var lineup_pos = $lineup_pos


signal health_changed


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

		
			#if collision != null:
				#print("Collided with: ", collision.collider.name)


		motion()
		move_and_slide(velocity)

func die():
	queue_free()


func control(delta):
	pass
	
	
func attack_mode():
	pass	
	
func swing(type):
	if blocked == false:
		if type == str('C1'):
			state_machine.travel('swingW_shield_1hand')
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
	for i in get_slide_count():
		var collision = get_slide_collision(i)
	
	if velocity.length() > 12:
		if movement_type == 'normal':
			if blocking == false:
				state_machine.travel('walking_shield_1hand')
			$movement.play('walking')
			$movement.set_speed_scale(velocity.length()/50)
			#print($movement.get_speed_scale())
		if movement_type == 'swinging':
			state_machine.travel('swingW_shield_1hand')
			movement_type = 'normal'
		if movement_type == 'shiftingL':
			$movement.play('shiftingL')
		if movement_type == 'shiftingR':
			$movement.play('shiftingR')
	else:
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
