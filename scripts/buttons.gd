extends VBoxContainer


func _ready():
	pass

func _on_Button_pressed():
	get_tree().change_scene("res://scenes/arena.tscn")


func _on_Button2_pressed():
	get_tree().change_scene("res://scenes/credits.tscn")


func _on_Button3_pressed():
	get_tree().change_scene("res://scenes/help.tscn")


func _on_Button4_pressed():
	get_tree().quit()
