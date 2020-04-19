extends KinematicBody2D

var moveSpeed = 50000
var immune = false
var health = 5

onready var stateMachine = $"../StateMachine"
onready var gun = $"../gun"

func _ready():
	pass
	
func _process(delta):
	var motion = stateMachine.motion
	move_and_slide(motion*moveSpeed*delta)
	
func loseHealth():
	if !immune:
		health -=1
		immune = true
		yield(get_tree().create_timer(1), "timeout")
		immune = false

func getRandomWeapon():
	var randGun = randi() % 2 + 1
	gun.currentGun = randGun
	if randGun == gun.guntypes.RIFLE: gun.ammo = 30
	else: gun.ammo = 30
