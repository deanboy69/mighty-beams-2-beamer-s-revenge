extends Control

var area = 10000
var min_width
var min_height
var right_drag_limit
var down_drag_limit
var unit_count = 80

var width
var height
var rect
var width_rel
var height_rel


var rot_dir = 0

onready var b_left = $left
onready var b_right = $right
onready var b_up = $up
onready var b_down = $down








func _ready():
	min_height = 50
	min_width = 50




func _process(delta):
	set_button_locations()
	update_rect()


	

	
func set_button_locations():
	width = clamp(b_right.get_global_position().x - b_left.get_global_position().x,min_width,area/min_height)
	width_rel = b_left.get_global_position().x + width/2
	height = area / width
	height_rel = b_up.get_global_position().y+height/2
	
	if b_right.pressed:
		b_right.set_global_position(Vector2(get_global_mouse_position().x,height_rel))
	else:
		b_right.set_global_position(Vector2(width,height_rel))
	
	b_left.set_global_position(Vector2(b_left.get_global_position().x,height_rel))
	b_up.set_global_position(Vector2(width_rel,b_up.get_global_position().y))
	b_down.set_global_position(Vector2(width_rel,b_down.get_global_position().y))
	


func update_rect():
	$rect.set_global_position(Vector2(b_left.get_global_position().x+20,b_up.get_global_position().y+20))
	$rect.set_size(Vector2(width-20,height-20))
		
		
		

		
		
		
		
		
		
		


	