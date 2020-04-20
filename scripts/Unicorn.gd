extends YSort

var carried = false
var health = 4
var immune = false

onready var player = $"../PlayerBody"

func _process(delta):
	if carried:
		global_position = player.global_position
		$"Sprite".rotation_degrees = 90
		player.moveSpeed = 2 * 10000
		if Input.is_action_just_pressed("shoot"):
			carried = false
			yield(get_tree().create_timer(0.1), "timeout")
			player.set_carrying(false)
	else:
		$"Sprite".rotation_degrees = 0
		player.moveSpeed = 5 * 10000
		if Input.is_action_just_pressed("shoot") and player in $"Area2D".get_overlapping_bodies():
			carried = true
			player.set_carrying(true)
		
func loseHealth():
	if !immune:
		health -=1
		$"../UI/Health Bar".get_child(0).queue_free()
		if health <= 0:
			get_tree().change_scene("res://scenes/game over.tscn")
		immune = true
		yield(get_tree().create_timer(1), "timeout")
		immune = false
