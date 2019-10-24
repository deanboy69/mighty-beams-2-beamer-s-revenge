extends KinematicBody2D

signal health_changed
signal dead

export (int) var max_speed
export (float) var rotation_speed
export (float) var attack_speed

export (int) var max_health
export (int) var damage

var attack_cooldown = false

var velocity = Vector2()
var can_strike = true
var alive = true
var health
var speed = max_speed


var state_machine
var blocking = false
var blocked = false


var blend


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



func _ready():
	health = max_health
	emit_signal('health_changed', health*100/max_health)
	$AnimationTree.set_active(true)
	state_machine = $AnimationTree.get('parameters/playback')
	state_machine.start('idle')
	$movement.playback_speed = 2
	
	
	
func control(delta):
	pass
	
func take_damage(amount):
	if alive:
		health -= amount
		emit_signal('health_changed', health*100/max_health)
		if health <= 0:
			die()
	if name == 'player':
		print(health)

func die():
	alive = false
	state_machine.travel('die')
	$movement.queue_free()
	
	#$movement.queue_free()

	queue_free()

func _process(delta):
	$ui.global_rotation = 0
	
func _physics_process(delta):
	if alive:
		control(delta)
		move_and_slide(velocity)
		motion()

func attack_mode():
	pass	
	
func swing(type):
	if blocked == false:
		if type == str('C1'):
			state_machine.travel('swing_C1')
	else:
		pass
		

func stab():
	state_machine.travel('shield_stab')
	pass
		


func block():
	state_machine.travel('shield_raise')
	blocking = true
	
func shield_return():
	state_machine.travel('shield_lower')
	blocking = false

	
func motion():
	if velocity != Vector2(0,0):
		$movement.play('walking')
	if abs(velocity.x) < 6 and abs(velocity.y) < 6:
		velocity = Vector2(0,0)
		if $movement.current_animation == 'walking':
			$movement.stop()
		if $body/legs/legs.texture in [frame0,frame5,frame6,frame11]:
			pass
		elif $body/legs/legs.texture in [frame1,frame2,frame3,frame4]:
			$body/legs/legs.texture = frame0
		elif $body/legs/legs.texture in [frame7]:
			$body/legs/legs.texture = frame5
		elif $body/legs/legs.texture in [frame8]:
			$body/legs/legs.texture = frame6
		elif $body/legs/legs.texture in [frame9,frame10]:
			$body/legs/legs.texture = frame11



		
		
func _on_area_body_entered(body):
	if body.owner != self:
		if body.has_method('take_damage'):
			body.take_damage(damage)
		if body.name == 'kbody':
			print('kbody')
			blocked = true
			state_machine.travel('swing_C1_blocked')

func _on_area_body_exited(body):
	if body.owner != self:
		if body.name == 'kbody':
			print('kbody')
			blocked = false
			#state_machine.travel('swing_C1_blocked')
