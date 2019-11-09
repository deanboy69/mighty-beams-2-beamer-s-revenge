extends Node2D

func _ready():
	$player.init(100,3,40,10)
	$player/player_camera.make_current()