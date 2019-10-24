extends "res://scripts/human.gd"





onready var parent = get_parent()
onready var highlight = $selectArea/selectTexture



var target = null


var destination_dir = Vector2()
var destination_dist = Vector2()
var current_dir = Vector2()




func _ready():
	pass
	
	
	
	
func _process(delta):
	pass
		


	

	
func control(delta):
	if target:
		destination_dir = (target.global_position - global_position).normalized()
		destination_dist = global_position.distance_to(target.global_position)
		current_dir = Vector2(1,0).rotated(rotation)
		rotation = current_dir.linear_interpolate(destination_dir,rotation_speed*delta).angle()
		if destination_dist > 30:	
			velocity = Vector2(linear_speed, 0).rotated(rotation)
		else:
			velocity = Vector2(0,0)
			#attack script here	


			





func _on_detect_zone_body_entered(body):
	if target == null:
		if body.name == 'player':
			target = body

