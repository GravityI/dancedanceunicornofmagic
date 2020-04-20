extends Node2D

signal crossfadeIn
signal crossfadeOut

onready var note = $"note"

func _ready():
	connect("crossfadeIn", $"../audioManager", "_on_Boombox_entered")
	connect("crossfadeOut", $"../audioManager", "_on_Boombox_exited")


func _on_Area2D_area_entered(area):
	if area.is_in_group("unicorn"):
		emit_signal("crossfadeIn")
		globals.multiplier = 3


func _on_Area2D_area_exited(area):
	if area.is_in_group("unicorn"):
		emit_signal("crossfadeOut")
		globals.multiplier = 1


func _on_lifetime_timeout():
	$"../entitiesSpawner".spawn($"../entitiesSpawner".boombox)
	queue_free()
