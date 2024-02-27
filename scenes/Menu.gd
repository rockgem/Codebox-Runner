extends Control




func _ready():
	get_tree().paused = false
	
	ManagerGame.reset_game()
	
	$SettingsPanel/HBoxContainer/Music.button_pressed = !AudioServer.is_bus_mute(0)


func _on_gui_input(event):
	if event is InputEventScreenTouch and !event.pressed:
		ManagerGame.reset_game()
		
		Sfx.play_sound('Pop')
		
		$ModeSelectPanel.show()


func _on_close_pressed():
	$ModeSelectPanel.hide()


func _on_endless_mode_pressed():
	ManagerGame.game_mode = ManagerGame.GAME_MODE.ENDLESS
	get_tree().change_scene_to_file("res://scenes/World.tscn")


func _on_chill_mode_pressed():
	ManagerGame.game_mode = ManagerGame.GAME_MODE.CHILL
	get_tree().change_scene_to_file("res://scenes/World.tscn")


func _on_settings_pressed():
	$SettingsPanel.visible = !$SettingsPanel.visible


func _on_settings_close_pressed():
	$SettingsPanel.hide()


func _on_music_toggled(toggled_on):
	AudioServer.set_bus_mute(0, !toggled_on)
