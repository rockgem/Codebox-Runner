extends CharacterBody2D


@onready var aim = $Aim

var swiping = false

var lane = 1
var lane_max = 2

var lanes = [
	Vector2(48,288),
	Vector2(64,288),
	Vector2(80,288),
	]

var is_jumping = false


func _ready():
	ManagerGame.player_ref = self


func _unhandled_input(event):
	if is_jumping:
		return
	
	if event is InputEventScreenTouch and !event.pressed or Input.is_action_just_pressed('ui_up'):
		jump()
	
	if Input.is_action_just_pressed('ui_left'):
		move_left()
	
	if Input.is_action_just_pressed('ui_right'):
		move_right()
	
	#if event is InputEventScreenDrag and event.is_pressed() and swiping == false:
		#swiping = true
	#
	#if event is InputEventScreenDrag and !event.is_pressed() and swiping == true:
		#swiping = false
		#slide(event.relative)


func move_left():
	if lane > 0:
		var t = create_tween()
		t.tween_property(self, 'global_position:x', lanes[lane - 1].x, .2)
		#global_position.x -= 16.0
	lane = clamp(lane - 1, 0, lane_max)


func move_right():
	if lane < lane_max:
		var t = create_tween()
		t.tween_property(self, 'global_position:x', lanes[lane + 1].x, .2)
		#global_position.x += 16.0
	lane = clamp(lane + 1, 0, lane_max)


func check_sides(direction) -> bool:
	var col = $Aim/RayCast2D.get_collider()
	if col:
		return false
	
	return true


func jump():
	if is_jumping:
		return
	
	$CollisionShape2D.disabled = true
	
	is_jumping = true
	
	var t = create_tween()
	t.tween_property($AnimatedSprite2D, 'position:y', -16, .3)
	t.tween_property($AnimatedSprite2D, 'position:y', 13.0, .3)
	
	await t.finished
	
	is_jumping = false
	$CollisionShape2D.disabled = false
