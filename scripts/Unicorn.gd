extends YSort

var carried = false
var health = 5
var immune = false

onready var player = $"../PlayerBody"

func _process(delta):
	if carried:
		global_position = player.global_position
		$"Sprite".rotation_degrees = 90
		if Input.is_action_just_pressed("shoot"):
			carried = false
	else:
		$"Sprite".rotation_degrees = 0
		if Input.is_action_just_pressed("shoot") and player in $"Area2D".get_overlapping_bodies():
			carried = true
		

func loseHealth():
	if !immune:
		health -=1
		immune = true
		yield(get_tree().create_timer(1), "timeout")
		immune = false
