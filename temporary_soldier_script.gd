extends "res://scripts/human.gd"



#export (int) var detect_radius




export var selected = false setget set_selected

onready var parent = get_parent()
onready var highlight = $selectArea/selectTexture



var destination = null
var destination_dir = Vector2()
var destination_dist = Vector2()
var current_dir = Vector2()
var move_backward = false

var move_p = false
var to_move = Vector2()
var path = PoolVector2Array()
var initialposition = Vector2()

signal was_selected
signal was_deselected

func _ready():
	connect("was_selected",get_parent(),"select_unit")
	connect("was_deselected",get_parent(),"deselect_unit")
	highlight.visible = false
	
	
	
	
func _process(delta):
	pass
		


	

	
func control():
	velocity = Vector2()
	if alive:
		if move_backward == true:
			velocity = -Vector2(linear_speed/2, 0)
		elif move_backward == false:
			if destination != null:
				velocity = Vector2(linear_speed, 0)
		if move_p:
			path = get_viewport().get_node("map2/navigation1").get_simple_path(position, to_move)#+Vector2(randi()%100, randi()%100))
			initialposition = position
			move_p = false
		if path.size() > 0:
			#print(path)
			move_towards(initialposition, path[0])
		if destination:
			destination_dir = (destination - global_position).normalized()
			destination_dist = global_position.distance_to(destination)
			current_dir = Vector2(1,0).rotated(rotation)
			#rotation = current_dir.linear_interpolate(destination_dir,turn_speed*delta).angle()
			print(current_dir)
			print(destination_dir)
	
			#if not $body/melee_range.is_colliding():
			#	linear_speed = lerp(linear_speed,max_speed,0.1)
			if $melee_range.is_colliding():
				if not $too_close.is_colliding():
					linear_speed = 0
					swing('C1')
				elif $too_close.is_colliding():
					move_backward = true
					$moveback_timer.start()
			if destination_dist < 5:
				linear_speed = 0
				destination = null
			
		
func move_towards(pos, point):
	#print(point)
	destination = point
	#velocity = (point - pos).normalized()
	if position.distance_squared_to(point) < 9:
		path.remove(0)
		initialposition = position

func move_unit(point):
	print(velocity)
	#print(point)
	to_move = point
	move_p = true


func set_selected(value):
	if selected != value:
		selected = value
		highlight.visible = value
		if selected:
			emit_signal("was_selected",self)
		else:
			emit_signal("was_deselected",self)
			
			
			
func die2():
	#destination = null
	queue_free()
	#$detect_radius/CollisionShape2D.set_disabled(true)

func _input(event):
	if selected:
		if event is InputEventMouseButton:
			if event.is_pressed():
				if event.button_index == BUTTON_LEFT:
					set_selected(false)
		
		
		
		
		
		
