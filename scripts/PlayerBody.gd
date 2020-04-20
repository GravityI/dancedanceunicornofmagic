extends KinematicBody2D

var moveSpeed = 5000
var immune = false

onready var stateMachine = $"../StateMachine"
onready var gun = $"../gun"

onready var viewportSize = get_viewport().size/2
	
func _process(delta):
	var motion = stateMachine.motion
	move_and_slide(motion*moveSpeed*delta)
	if !self in $"../Unicorn/Area2D".get_overlapping_bodies():
		var unicornPos = $"../Unicorn".global_position
		global_position.x = clamp(global_position.x, unicornPos.x - viewportSize.x, unicornPos.x + viewportSize.x)
		global_position.y = clamp(global_position.y, unicornPos.y - viewportSize.y, unicornPos.y + viewportSize.y)

func getRandomWeapon():
	var randGun = randi() % 2 + 1
	gun.currentGun = randGun
	gun.ammo = 60

func set_carrying(value): stateMachine.carrying = value
