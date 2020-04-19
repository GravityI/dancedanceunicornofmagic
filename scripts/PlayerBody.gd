extends KinematicBody2D

var moveSpeed = 5000
var immune = false

onready var stateMachine = $"../StateMachine"
onready var gun = $"../gun"

func _ready():
	pass
	
func _process(delta):
	var motion = stateMachine.motion
	move_and_slide(motion*moveSpeed*delta)
	if !self in $"../Unicorn/Area2D".get_overlapping_bodies():
		var unicornPos = $"../Unicorn".global_position
		global_position.x = clamp(global_position.x, unicornPos.x - 480, unicornPos.x + 480)
		global_position.y = clamp(global_position.y, unicornPos.y - 280, unicornPos.y + 280)

func getRandomWeapon():
	var randGun = randi() % 2 + 1
	gun.currentGun = randGun
	if randGun == gun.guntypes.RIFLE: gun.ammo = 30
	else: gun.ammo = 30

func set_carrying(value): stateMachine.carrying = value
