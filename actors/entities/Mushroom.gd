extends Area2D
class_name Plant

enum PLANT_TYPE{
	MUSHROOM,
	CABBAGE,
	CARROT,
}

var plant_type = PLANT_TYPE.MUSHROOM
var id = ''

func _ready():
	match plant_type:
		PLANT_TYPE.MUSHROOM:
			$Sprite2D.texture = load("res://reso/icons/items/Mushroom.tres")
			id = 'Mushroom'
		PLANT_TYPE.CABBAGE:
			$Sprite2D.texture = load("res://reso/icons/items/Cabbage.tres")
			id = 'Cabbage'
		PLANT_TYPE.CARROT:
			$Sprite2D.texture = load("res://reso/icons/items/Carrot.tres")
			id = 'Carrot'


func _on_body_entered(body):
	Sfx.play_sound('PopRapid')
	
	ManagerGame.score += 1
	
	ManagerGame.world_ref.collections_data[id] += 1
	
	ManagerGame.plant_collected.emit()
	
	queue_free()
