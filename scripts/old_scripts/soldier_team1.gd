extends "res://scripts/human.gd"



export var selected = false setget set_selected

onready var parent = get_parent()
onready var highlight = $selectArea/selectTexture



var destination = null
var destination_dir = Vector2()
var destination_dist = Vector2()



signal was_selected
signal was_deselected

func _ready():
	connect("was_selected",get_parent(),"select_unit")
	connect("was_deselected",get_parent(),"deselect_unit")
	highlight.visible = false
	
	
	
	
func _process(delta):
	print(selected)
		


	

	
func control():
	velocity = Vector2()
	rotation_dir = 0
	if destination:
		velocity = Vector2(linear_speed, 0)
		rotation_dir = position.angle_to(destination)
		destination_dir = (destination - global_position).normalized()
		destination_dist = global_position.distance_to(destination)
		if destination_dist < 5:
			destination = null



func set_selected(value):
	if selected != value:
		selected = value
		highlight.visible = value
		if selected:
			emit_signal("was_selected",self)
		else:
			emit_signal("was_deselected",self)
			

func die2():
	queue_free()

func _input(event):
	if selected:
		if event is InputEventMouseButton:
			if event.is_pressed():
				if event.button_index == BUTTON_LEFT:
					set_selected(false)
