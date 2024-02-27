extends Node


signal block_deleted
signal block_instantiate
signal game_over
signal plant_collected(type)


enum GAME_MODE{
	ENDLESS,
	CHILL
}

var save_path = 'user://player_data.json'

var player_data = {
	"level": 1,
	"exp": 0,
	"exp_max": 100,
	"high_score": 0,
	"last_score": 0,
}

var score: int = 0
var game_mode = GAME_MODE.ENDLESS

var block_speed = 70.0

var player_ref = null
var world_ref = null


func _ready():
	if FileAccess.file_exists(save_path):
		load_game()


func _notification(what):
	if what == NOTIFICATION_APPLICATION_PAUSED or what == NOTIFICATION_WM_CLOSE_REQUEST:
		save_game()


func reset_game():
	block_speed = 70.0
	score = 0


func save_game():
	var f = FileAccess.open(save_path, FileAccess.WRITE)
	f.store_string(JSON.stringify(player_data))
	
	f.close()


func load_game():
	player_data = get_data(save_path)


func get_data(path):
	var data
	
	var f = FileAccess.open(path, FileAccess.READ)
	var j = JSON.new()
	j.parse(f.get_as_text())
	data = j.data
	
	return data


func add_exp(amount):
	player_data['exp'] += amount
	
	if player_data['exp'] >= player_data['exp_max']:
		player_data['level'] =+ 1
		player_data['exp'] = 0
		
		player_data['exp_max'] * 1.2
