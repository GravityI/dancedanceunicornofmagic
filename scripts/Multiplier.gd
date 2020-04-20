extends Label


func _ready():
	pass

func _process(delta):
	if globals.multiplier == 3:
		show()
	else:
		hide()
