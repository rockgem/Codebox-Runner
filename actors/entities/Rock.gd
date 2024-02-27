extends Area2D
class_name Obstacle

enum OBSTACLE_TYPE{
	ROCK,
	STUMP,
}

var obstacle_type = OBSTACLE_TYPE.ROCK



func _ready():
	match obstacle_type:
		OBSTACLE_TYPE.ROCK: $Sprite2D.texture = load("res://reso/sprites/Rock.tres")
		OBSTACLE_TYPE.STUMP: $Sprite2D.texture = load("res://reso/sprites/Stump.tres")


func _on_body_entered(body):
	ManagerGame.game_over.emit()
	
	Sfx.play_sound('Hit')

# if a plant overlaps this area delete the plant
func _on_area_entered(area):
	area.queue_free()
