extends Node2D

enum guntypes {PISTOL, RIFLE, SHOTGUN}

const bullet = preload("res://scenes/bullet.tscn")

var currentGun
var ammo = 60
var canShoot = true

onready var playerBody = $"../PlayerBody"
onready var spawnPos = $"spawnPos"
onready var stateMachine = $"../StateMachine"

func _ready():
	currentGun = guntypes.RIFLE

func _process(delta):
	position = playerBody.position
	if stateMachine.state in [stateMachine.states.IDLE, stateMachine.states.WALK]:
		
		pass
	look_at(get_global_mouse_position())
	if Input.is_action_pressed("shoot") and canShoot:
		print(ammo)
		spawnBullet()
		if currentGun == guntypes.PISTOL:
			$"cooldown".wait_time = 1
		elif currentGun == guntypes.RIFLE:
			$"cooldown".wait_time = 0.1
		else:
			$"cooldown".wait_time = 1
			spawnBullet(45)
			spawnBullet(-45)
			$"cooldown".wait_time = $"cooldown".wait_time
		$"cooldown".start()
		canShoot = false
	if ammo == 0:
		currentGun = guntypes.PISTOL

func spawnBullet(angle = 0):
	if currentGun != guntypes.PISTOL: ammo -= 1
	var newBullet = bullet.instance()
	newBullet.position = spawnPos.global_position
	newBullet.direction = newBullet.position.direction_to(get_global_mouse_position()).rotated(angle).normalized()
	get_parent().add_child(newBullet)

func _on_cooldown_timeout():
	canShoot = true
