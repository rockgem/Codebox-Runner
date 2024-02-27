extends Node2D

var has_instantiated = false

@onready var tilemap_ref = $TileMap0

func _ready():
	var rand = randi() % 2
	
	tilemap_ref.hide()
	var rand_type = randi() % 3
	tilemap_ref = find_children('TileMap%s' % rand_type)[0]
	tilemap_ref.show()
	
	#if rand == 0:
		#generate_mushroom()
	
	await get_tree().process_frame
	
	generate_mushroom()


func _physics_process(delta):
	#if global_position.y >= 0.0 and has_instantiated == false:
		#has_instantiated = true
		#ManagerGame.block_instantiate.emit()
	
	if global_position.y >= 0.0 and has_instantiated == false:
		has_instantiated = true
		
		ManagerGame.block_instantiate.emit()
	
	if global_position.y >= 400.0:
		ManagerGame.block_deleted.emit()
		
		queue_free()
		return
	
	global_position.y += ManagerGame.block_speed * delta


func generate_mushroom():
	var cells = tilemap_ref.get_used_cells(3)
	var temp = cells
	temp.shuffle()
	
	var init_cell = temp[0]
	
	var rand_amount = randi_range(6, 10)
	var rand_amount_obstacles = randi_range(1, 3)
	
	var rand_plant_type = randi() % 3
	var count = 0
	for i in rand_amount:
		var mushroom = load("res://actors/entities/Mushroom.tscn").instantiate()
		mushroom.plant_type = rand_plant_type
		
		mushroom.global_position.x = init_cell.x * 16.0
		mushroom.global_position.y = init_cell.y + (16.0 * count)
		
		count += 1
		add_child(mushroom)
	
	temp.remove_at(0)
	
	count = 0
	for i in rand_amount_obstacles:
		var rand_obs = randi() % 2
		
		var obstacle = load("res://actors/entities/Rock.tscn").instantiate()
		obstacle.obstacle_type = rand_obs
		obstacle.global_position = temp[count] * 16.0
		
		count += 1
		
		add_child(obstacle)
