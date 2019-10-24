extends Control


func _ready():
	pass
	
	
	




func _on_host_button_pressed():
	ConnectionManager.on_host_game()


func _on_join_button_pressed():
	var ip = $Panel/join_game/IP_enter.text
	ConnectionManager.on_join_game(ip)
