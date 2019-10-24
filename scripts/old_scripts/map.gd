extends Node2D

#const UNIT = preload('res://scenes/enemy_unit.tscn')

onready var player_camera = false

onready var button = preload('res://scenes/button.tscn')
var buttons = []

var selected_units = []
var units = []

func select_unit(unit):
	if not selected_units.has(unit):
		selected_units.append(unit)
	#print("selected %s" %unit.name)
	create_buttons()
	
func deselect_unit(unit):
	if selected_units.has(unit):
		selected_units.erase(unit)
	#print("deselected %s" %unit.name)
	create_buttons()
	
func deselect_all():
	while selected_units.size() > 0:
		selected_units[0].set_selected(false)

func create_buttons():
	delete_buttons()
	for unit in selected_units:
		if not buttons.has(unit.name):
			var but = button.instance()
			but.connect_me(self,unit.name)
			but.rect_position = Vector2(buttons.size() * 64 - 120, -75)
			$ui/base.add_child(but)
			buttons.append(but.name)

func delete_buttons():
	for but in buttons:
		if $ui/base.has_node(but):
			var b = $ui/base.get_node(but)
			#print(b)
			b.queue_free()
			$ui/base.remove_child(b)
	buttons.clear()


func was_pressed(obj):
	for unit in selected_units:
		if unit.name == obj.name:
			unit.set_selected(false)
			break
			
			
func get_units_in_area(area):
	var u = []
	for unit in units:
		#print(unit)
		if unit.position.x > area[0].x and unit.position.x < area[1].x:
			if unit.position.y > area[0].y and unit.position.y < area[1].y:
				u.append(unit)
	return u

func area_selected(obj):
	var start = obj.start
	var end = obj.end
	var area = []
	area.append(Vector2(min(start.x, end.x), min(start.y, end.y)))
	area.append(Vector2(max(start.x, end.x), max(start.y, end.y)))
	var ut = get_units_in_area(area)
	if not Input.is_key_pressed(KEY_SHIFT):
		deselect_all()
	for u in ut:
		u.selected = not u.selected
		
func start_move_selection(obj):
	print(obj.move_to_point)
	for un in selected_units:
		un.move_unit(obj.move_to_point)


func _ready():
	set_camera_limits()
	units = get_tree().get_nodes_in_group("allies")
	
	
#	var unit = UNIT.instance()
#	unit.addAsGrid(Vector2(8, 4))
#	add_child(unit)


func _process(delta):
	if Input.is_action_just_pressed('switch_camera'):
		player_camera = not player_camera
		print('switch')
		switch_cameras(player_camera)
		
	

func switch_cameras(player_camera):
	if player_camera == true:
		$map_view.active = false
		$player/player_camera.make_current()
	if player_camera == false:
		$map_view.active = true
		$map_view.make_current()
	
func set_camera_limits():
	var map_limits = $ground.get_used_rect()
	var map_cellsize = $ground.cell_size
#	$map_view.limit_left = map_limits.position.x * map_cellsize.x
#	$map_view.limit_right = map_limits.end.x * map_cellsize.x
#	$map_view.limit_top = map_limits.position.y * map_cellsize.y
#	$map_view.limit_bottom = map_limits.end.y * map_cellsize.y

