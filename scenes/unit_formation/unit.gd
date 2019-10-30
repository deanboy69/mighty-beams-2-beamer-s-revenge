extends Control

var rot_dir = 0

var unit_count
var unit_type


onready var rect_adjuster = preload("res://scenes/unit_formation/rect_adjuster.tscn").instance()
#var mySprite = preload("res://mySprite.scn").instance()
#mySprite.init(a, b)
#getparent().add_child(mySprite)

func init(type,count):
	unit_count = count
	unit_type = type


func _ready():
	#testing
	unit_count = 20
	unit_type = 'regular'
	
	
	
	rect_adjuster.init(unit_count)
	add_child(rect_adjuster)
	
	
	
	


func _process(delta):
	rotate_unit()
	move_unit()

	
func rotate_unit():
	
	if Input.is_action_pressed('turn_left'):
		rot_dir += .1
	if Input.is_action_pressed('turn_right'):
		rot_dir -= .1
	set_rotation(rot_dir)
	#set_pivot_offset(rect_adjuster.pivot_point.get_global_position())
	
func move_unit():
	pass