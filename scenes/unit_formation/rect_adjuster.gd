extends Control

var area
var min_width
var min_height
var drag_limit


var width
var height
var rect
var width_rel
var height_rel


onready var b_left = $left
onready var b_right = $right
onready var b_up = $up
onready var b_down = $down
onready var pivot_point = $pivot





func init(unit_size):
	area = unit_size * 500 



func _ready():
	min_height = 50
	min_width = 50




func _process(delta):
	set_button_locations()
	update_rect()



	

	
func set_button_locations():
	width = clamp(b_right.get_position().x - b_left.get_position().x,min_width,area/min_height)
	width_rel = b_left.get_position().x + width/2
	height = area / width
	height_rel = b_up.get_position().y+height/2
	
	if b_right.pressed:
		drag_limit = clamp(get_local_mouse_position().x,$rect.get_position().x,$rect.get_position().x+width)
		b_right.set_position(Vector2(drag_limit,height_rel))
	else:
		b_right.set_position(Vector2(width,height_rel+5))
	
	b_left.set_position(Vector2(b_left.get_position().x,height_rel))
	b_up.set_position(Vector2(width_rel,b_up.get_position().y))
	b_down.set_position(Vector2(width_rel,b_down.get_position().y))
	


func update_rect():
	$rect.set_position(Vector2(b_left.get_position().x+20,b_up.get_position().y+20))
	$rect.set_size(Vector2(width-20,height-20))
	pivot_point.set_position(Vector2($rect.get_position().x+width/2,$rect.get_position().y+height/2))
		
		
		

		

		
		
		
		
		
		
		


	