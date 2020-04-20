extends Label


func _ready():
	globals.score = 0

func _process(delta):
	text = str(globals.score*10)


func _on_scoreTimer_timeout():
	globals.score += 1 * globals.multiplier
