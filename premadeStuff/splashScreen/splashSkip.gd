extends VideoPlayer

func _process(delta):
	if Input.is_action_just_pressed("shoot"):
		get_tree().change_scene("res://scenes/menu.tscn")

func _on_splashPlayer_finished():
	get_tree().change_scene("res://scenes/menu.tscn")
