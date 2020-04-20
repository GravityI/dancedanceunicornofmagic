extends Node

#const drive = preload("res://audio/AlexBeroza_-_Drive.ogg")
#const sister = preload("res://audio/Robbero_-_Soul_sister.ogg")
const speed = 50

var fade = false
var currentFade = 1
var nextFade = -1
var maxVolume = -22

onready var sister = $"sister"
onready var drive = $"drive"
onready var currentPlayer = sister
onready var nextPlayer = drive
	
func _process(delta):
	crossfade(delta)
	
func crossfade(delta):
	currentPlayer.volume_db += delta*speed*currentFade
	nextPlayer.volume_db += delta*speed*nextFade
	
	currentPlayer.volume_db = clamp(currentPlayer.volume_db, -72, maxVolume)
	nextPlayer.volume_db = clamp(nextPlayer.volume_db, -72, maxVolume)
	
func stopAll():
	for child in get_children():
		child.stop()

func changeFadeDirection():
	currentFade *= -1
	nextFade *= -1
	
func _on_Boombox_entered():
	changeFadeDirection()

func _on_Boombox_exited():
	changeFadeDirection()
