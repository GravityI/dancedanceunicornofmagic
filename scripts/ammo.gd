extends Label


func _ready():
	pass

func _process(delta):
	if $"../../gun".currentGun != $"../../gun".guntypes.PISTOL:
		show()
		text = str($"../../gun".ammo)
	else:
		hide()
	
