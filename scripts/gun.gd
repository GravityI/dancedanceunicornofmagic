extends Node2D

enum guntypes {PISTOL, RIFLE, SHOTGUN}

const bullet = preload("res://scenes/bullet.tscn")

var currentGun
var ammo = 60
var canShoot = true
var shooting = false

onready var playerBody = $"../PlayerBody"
onready var spawnPos = $"spawnPos"
onready var stateMachine = $"../StateMachine"
onready var unicorn = $"../Unicorn"

func _ready():
	currentGun = guntypes.RIFLE

func _process(delta):
	position = playerBody.position
	if !stateMachine.carrying:
		look_at(get_global_mouse_position())
		if Input.is_action_just_pressed("shoot") and !playerBody in unicorn.get_node("Area2D").get_overlapping_bodies():
			shooting = true
		elif Input.is_action_just_released("shoot"):
			shooting = false
			
		if shooting and canShoot:
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
		
		if currentGun == guntypes.PISTOL:
			$"Sprite".animation = "pistol"
		elif currentGun == guntypes.RIFLE:
			$"Sprite".animation = "rifle"
		else:
			$"Sprite".animation = "shotgun"
		
		if playerBody in unicorn.get_node("Area2D").get_overlapping_bodies():
			hide()
		else:
			show()
	else:
		hide()
		

func spawnBullet(angle = 0):
	if currentGun != guntypes.PISTOL: ammo -= 1
	var newBullet = bullet.instance()
	newBullet.position = spawnPos.global_position
	newBullet.direction = newBullet.position.direction_to(get_global_mouse_position()).rotated(angle).normalized()
	get_parent().add_child(newBullet)

func _on_cooldown_timeout():
	canShoot = true
