extends Node2D

onready var parent = get_parent()
onready var bounds = get_viewport().size/2
onready var unicorn = $"../../Player/Unicorn"

func _process(delta):
	set_marker_position()

func set_marker_position():
	global_position.x = clamp(parent.global_position.x, unicorn.global_position.x - bounds.x, unicorn.global_position.x + bounds.x)
	global_position.y = clamp(parent.global_position.y, unicorn.global_position.y - bounds.y, unicorn.global_position.y + bounds.y)
	
	if parent.note.is_on_screen():
		hide()
	else:
		show()
