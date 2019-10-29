extends Control

var area = 100
var width = 100
var height = 100
var rect
var width_rel
var height_rel


var rot_dir = 0

onready var b_left = $left
onready var b_right = $right
onready var b_up = $up
onready var b_down = $down


#	width = b_left.get_global_position().x - b_right.get_global_position().x
#	height = b_up.get_global_position().y - b_down.get_global_position().y



func _ready():
	b_left.set_global_position(Vector2(0,50))
	b_right.set_global_position(Vector2(100,50))
	b_up.set_global_position(Vector2(50,0))
	b_down.set_global_position(Vector2(50,100))




func _process(delta):
	set_button_locations()
	update_rect()

	

	
func set_button_locations():
	width = b_right.get_global_position().x - b_left.get_global_position().x 
	width_rel = b_left.get_global_position().x + width/2
	height = b_down.get_global_position().y -  b_up.get_global_position().y 
	height_rel = b_up.get_global_position().y+height/2
	if b_left.pressed == false:
		b_left.set_global_position(Vector2(b_left.get_global_position().x,height_rel))
	if b_right.pressed == false:
		b_right.set_global_position(Vector2(b_right.get_global_position().x,height_rel))
	if b_up.pressed == false:
		b_up.set_global_position(Vector2(width_rel,b_up.get_global_position().y))
	if b_down.pressed == false:
		b_down.set_global_position(Vector2(width_rel,b_down.get_global_position().y))

	if b_left.pressed or b_right.pressed or b_up.pressed or b_down.pressed:
		print(Vector2(width,height))
	if b_left.pressed:
		b_left.set_global_position(Vector2(get_global_mouse_position().x,b_left.get_global_position().y))
	if b_right.pressed:
		b_right.set_global_position(Vector2(get_global_mouse_position().x,b_right.get_global_position().y))
	if b_up.pressed:
		b_up.set_global_position(Vector2(b_up.get_global_position().x,get_global_mouse_position().y))
	if b_down.pressed:
		b_down.set_global_position(Vector2(b_down.get_global_position().x,get_global_mouse_position().y))
		

func update_rect():
	pass
		
		
		

		
		
		
		
		
		
		


	