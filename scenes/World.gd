extends Node2D

var current_block = null

var collections_data = {
	"Carrot": 0,
	"Mushroom": 0,
	"Cabbage": 0
}

func _ready():
	ManagerGame.block_deleted.connect(on_block_deleted)
	ManagerGame.block_instantiate.connect(on_block_instantiate)
	ManagerGame.game_over.connect(game_over)
	
	ManagerGame.world_ref = self
	
	current_block = $Block


func game_over():
	get_tree().paused = true


func on_block_deleted():
	pass


func on_block_instantiate():
	var block = load("res://actors/components/Block.tscn").instantiate()
	block.global_position.y = -396.0 # this needs to be 396 and not exactly at -400 because there will be a gap
	
	current_block = block
	
	add_child(block)


func _physics_process(delta):
	pass


func _on_timer_timeout():
	if ManagerGame.game_mode == ManagerGame.GAME_MODE.ENDLESS:
		ManagerGame.block_speed += 10.0
