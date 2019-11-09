extends Node2D

var unit_size = 27
var unit_selected = false

onready var unit_organizer = $unit_organizer/container/grid
onready var SOLDIER = preload("res://scenes/human/NPC/NPC_Area2D.tscn")


func _ready():

	for i in range(0,unit_organizer.get_child_count()):
		var row = unit_organizer.get_child(i)
		print(row.name)
		for j in range(0,row.get_child_count()):
			if unit_size > (i*10)+j:
				var soldier = SOLDIER.instance()
				soldier.connect("unit_selected",self,"highlight_unit")
				#soldier.connect("unit_unselected",self,"unhighflight_unit")
				$soldiers.add_child(soldier)
				soldier.init(100,3,40,10,row.get_child(j))
				soldier.set_position(row.get_child(j).get_global_position())
				soldier.following_unit = true



		
#func unhighlight_unit():
#	for i in range(0,$soldiers.get_child_count()):
#		var soldier = $soldiers.get_child(i)
#		soldier.selected.visible = false
		
		
func _process(delta):
	for i in range(0,$soldiers.get_child_count()):
		var soldier = $soldiers.get_child(i)
		if soldier.selected.visible == true:
			unit_selected = true
			for i in range(0,$soldiers.get_child_count()):
				var selected_soldier = $soldiers.get_child(i)
				selected_soldier.selected.visible = true
			break
		else:
			unit_selected = false
			

