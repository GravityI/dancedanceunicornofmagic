extends Control


func _ready():
	$"Score".text = "You scored \n" + str(globals.score*10) + "\n points!"
