extends Node2D

const moveSpeed = 500

var direction

func _process(delta):
	global_position += direction * delta * moveSpeed


func _on_lifetime_timeout():
	queue_free()
