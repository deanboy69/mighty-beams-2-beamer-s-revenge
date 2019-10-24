extends Camera2D

onready var global = get_node("/root/global_variables")

var active = true
var player_pos = Vector2()





export var panSpeed = 20.0
export var zoomspeed = 80.0
export var zoommargin = 0.1
export var zoomMin = 1
export var zoomMax = 3.0







#
var mousepos = Vector2()
var mouseposGlobal = Vector2()
var start = Vector2()
var startv = Vector2()
var end = Vector2()
var endv = Vector2()
var zoompos = Vector2()
var zoomfactor = 1
var is_dragging = false
var move_to_point = Vector2()

onready var rectd = get_node('/root/map2/ui/base/drag_rect')
#
#


signal area_selected
signal start_move_selection


func _ready():
	connect("area_selected", get_parent(), "area_selected", [self])
	connect("start_move_selection", get_parent(), "start_move_selection", [self])


func _process(delta):
	player_pos = global.player_pos
	if active == true:
	#smooth movement
		var inpx = (int(Input.is_action_pressed('ui_right'))
						- int(Input.is_action_pressed('ui_left')))
		var inpy = (int(Input.is_action_pressed('ui_down'))
						- int(Input.is_action_pressed('ui_up')))
		position.x += inpx * panSpeed
		position.y += inpy * panSpeed
		#position.y = lerp(position.y, position.y * inpy, panSpeed * delta)
#		if mousepos.x < marginX:
#			position.x = lerp(position.x, position.x - abs(mousepos.x-marginX)/marginX * panSpeed * zoom.x, panSpeed * delta)
#		elif mousepos.x > OS.window_size.x - marginX:
#			position.x = lerp(position.x, position.x + abs(mousepos.x- OS.window_size.x + marginX)/marginX * panSpeed * zoom.x, panSpeed * delta)
#		if mousepos.y < marginY:
#			position.y = lerp(position.y, position.y - abs(mousepos.y-marginY)/marginY * panSpeed * zoom.y, panSpeed * delta)
#		elif mousepos.y > OS.window_size.y - marginY:
#			position.y = lerp(position.y, position.y + abs(mousepos.y-OS.window_size.y + marginY)/marginY * panSpeed * zoom.y, panSpeed * delta)
#
		
#	#zoom in
		zoom.x = lerp(zoom.x, zoom.x * zoomfactor, zoomspeed * delta)
		zoom.y = lerp(zoom.y, zoom.y * zoomfactor, zoomspeed * delta)
		zoom.x = clamp(zoom.x,zoomMin,zoomMax)
		zoom.y = clamp(zoom.y,zoomMin,zoomMax)


	
	if Input.is_action_just_pressed('left_mouse_button'):
		start = mouseposGlobal
		startv = mousepos
		is_dragging = true
	if is_dragging:
		end = mouseposGlobal
		endv = mousepos
		draw_area()
	if Input.is_action_just_released('left_mouse_button'):
		if startv.distance_to(mousepos) > 20:
			end = mouseposGlobal
			endv = mousepos
			is_dragging = false
			draw_area(false)
			emit_signal('area_selected')
			#print('emitt')
		else:
			end = start
			is_dragging = false
			draw_area(false)
			
	if Input.is_action_just_released('right_mouse_button'):
		move_to_point = mouseposGlobal
		emit_signal('start_move_selection')




func draw_area(s=true):
	rectd.rect_size = Vector2(abs(startv.x-endv.x),abs(startv.y-endv.y))
	
	var pos = Vector2()
	pos.x = min(startv.x,endv.x)#startv.x if (startv.x < endv.x) else endv.x
	pos.y = min(startv.y,endv.y)#startv.y if (startv.y < endv.y) else endv.y
	pos.y -= OS.window_size.y
	rectd.rect_position = pos
	
	rectd.rect_size *= int(s)


func _input(event):
	#print(zoomfactor)
	if abs(zoompos.x - get_global_mouse_position().x) > zoommargin:
		zoomfactor = 1
	if abs(zoompos.y - get_global_mouse_position().y) > zoommargin:
		zoomfactor = 1


	if active == true:
		if event is InputEventMouseButton:
			if event.is_pressed():
				if event.button_index == BUTTON_WHEEL_UP:
					zoomfactor -= .05
				if event.button_index == BUTTON_WHEEL_DOWN:
					zoomfactor += .05
				zoompos = mouseposGlobal#get_global_mouse_position()
				
	if event is InputEventMouse:
		mousepos = event.position
		mouseposGlobal = get_global_mouse_position()
			

