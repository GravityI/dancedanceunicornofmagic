extends Node2D

var health = 3
var target
var direction

func _ready():
	target = $"../Unicorn"

func _process(delta):
	direction = global_position.direction_to(target.global_position)
	position += direction

func _on_Area_area_entered(area):
	if area.is_in_group("bullet"): 
		health -= 1
		area.get_parent().queue_free()
	elif area.is_in_group("unicorn"):
		get_tree().change_scene("res://scenes/game over.tscn")

func _on_Area_body_entered(body):
	if body.is_in_group("player"):
		body.loseHealth()
