extends "res://scripts/human.gd"




export (float) var turn_speed
export (int) var detect_radius




export var selected = false setget set_selected

onready var parent = get_parent()
onready var highlight = $selectArea/selectTexture
onready var label = $ui/label
onready var healthBar = $ui/health


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
	label.visible = false
	healthBar.visible = false
	label.text = name
	healthBar.value = health
	
	
	
func _process(delta):
	if alive:
		if move_backward == true:
			velocity = -Vector2(speed, 0).rotated(rotation)
		elif move_backward == false:
			velocity = Vector2(speed, 0).rotated(rotation)
	else:
		velocity = Vector2(0,0)
		die2()
		


	

	
func control(delta):
	if move_p:
		path = get_viewport().get_node("map1/navigation1").get_simple_path(position, to_move)#+Vector2(randi()%100, randi()%100))
		initialposition = position
		move_p = false
	if path.size() > 0:
		#print(path)
		move_towards(initialposition, path[0])
	if destination:
		destination_dir = (destination - global_position).normalized()
		destination_dist = global_position.distance_to(destination)
		current_dir = Vector2(1,0).rotated(rotation)
		rotation = current_dir.linear_interpolate(destination_dir,turn_speed*delta).angle()
		print(current_dir)
		print(destination_dir)
		print(turn_speed)
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
		if destination_dist < 5:
			speed = 0
			destination = null
			
		
func move_towards(pos, point):
	#print(point)
	destination = point
	#velocity = (point - pos).normalized()
	if position.distance_squared_to(point) < 9:
		path.remove(0)
		initialposition = position

func move_unit(point):
	#print(point)
	to_move = point
	move_p = true


func set_selected(value):
	if selected != value:
		selected = value
		highlight.visible = value
		label.visible = value
		healthBar.visible = value
		if selected:
			emit_signal("was_selected",self)
		else:
			emit_signal("was_deselected",self)
			
			
func die2():
	destination = null
	$detect_radius/CollisionShape2D.set_disabled(true)

func _input(event):
	if selected:
		if event is InputEventMouseButton:
			if event.is_pressed():
				if event.button_index == BUTTON_LEFT:
					set_selected(false)
				
func _on_selectArea_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == BUTTON_LEFT:
				set_selected(true)

