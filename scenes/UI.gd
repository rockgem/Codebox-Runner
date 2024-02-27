extends Control


func _ready():
	ManagerGame.game_over.connect(game_over)
	ManagerGame.plant_collected.connect(on_plant_collected)
	
	$Score/Highscore.text = 'Highscore: %s' % ManagerGame.player_data['high_score']
	
	await get_tree().process_frame
	
	on_plant_collected()


func _physics_process(delta):
	$Score.text = 'Score: %s' % ManagerGame.score


func game_over():
	ManagerGame.player_data['last_score'] = ManagerGame.score
	
	if ManagerGame.score > ManagerGame.player_data['high_score']:
		$GameOverPanel/VBoxContainer/Highscore.show()
		ManagerGame.player_data['high_score'] = ManagerGame.score
	
	ManagerGame.add_exp(ManagerGame.score / 2)
	
	$GameOverPanel/VBoxContainer/Score.text = 'Score: %s' % ManagerGame.score
	$GameOverPanel.show()


func on_plant_collected():
	$Collections/HBoxContainer3/MushroomAmount.text = 'x%s' % ManagerGame.world_ref.collections_data['Mushroom']
	$Collections/HBoxContainer/CarrotAmount.text = 'x%s' % ManagerGame.world_ref.collections_data['Carrot']
	$Collections/HBoxContainer2/CabbageAmount.text = 'x%s' % ManagerGame.world_ref.collections_data['Cabbage']


func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://scenes/Menu.tscn")


func _on_left_pressed():
	ManagerGame.player_ref.move_left()


func _on_right_pressed():
	ManagerGame.player_ref.move_right()
