extends RigidBody2D


var linear_speed = 150
var velocity = Vector2()
var angular_speed = 3
var rotation_dir = 0

#health & attack
var max_health = 30
var health
#var damage = 10


signal health_changed


func _ready():
	$animatedSprite.animation = 'default'
	health = max_health
	emit_signal('health_changed', health*100/max_health)
	
func _process(delta):
	pass
	
func _physics_process(delta):
	control()
	set_linear_velocity(velocity.rotated(rotation))
	set_angular_velocity(rotation_dir*angular_speed)

func control():
	pass
	
	
func take_damage(amount):
	health -= amount
	emit_signal('health_changed', health*100/max_health)
	if health <= 0:
		die()
		
func die():
	$left.queue_free()
	$right.queue_free()
	$collision.queue_free()
	$vulnerable_area.queue_free()
	$animatedSprite.animation = 'dead'
	$animatedSprite.z_index = -1
	



func _on_vulnerable_area_body_entered(body):
	if body.owner != self:
		take_damage(body.owner.damage)
