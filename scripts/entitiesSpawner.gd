extends Node

const lootbox = preload("res://scenes/lootbox.tscn")
const boombox = preload("res://scenes/boombox.tscn")
const enemy = preload("res://scenes/Enemy.tscn")
const arenaCorners = Vector2(1024, 600)

onready var unicorn = $"../Player/Unicorn/"

func _ready():
	randomize()
	spawn(enemy)
	spawn(lootbox)
	spawn(boombox)
	
func randomPositionX():
	return rand_range(-arenaCorners.x, arenaCorners.x)

func randomPositionY():
	return rand_range(-arenaCorners.y, arenaCorners.y)

func randomUnseenPosition():
	var spawnPos = Vector2(randomPositionX(), randomPositionY())
	while abs(abs(spawnPos.x) - abs(unicorn.global_position.x)) < 512:
		spawnPos.x = randomPositionX()
	while abs(abs(spawnPos.y) - abs(unicorn.global_position.y)) < 300:
		spawnPos.y = randomPositionY()
	return spawnPos

func spawn(entity):
	var newEntity = entity.instance()
	newEntity.position = randomUnseenPosition()
	get_parent().call_deferred("add_child", newEntity)

func _on_enemySpawnTimer_timeout():
	spawn(enemy)
	if $"enemySpawnTimer".wait_time > 1:
		$"enemySpawnTimer".wait_time -= 0.01


func _on_lootboxSpawnTimer_timeout():
	spawn(lootbox)


#func _on_boomboxSpawnTimer_timeout():
#	spawn(boombox)
#	if $"boomboxSpawnTimer".wait_time > 20:
#		$"boomboxSpawnTimer".wait_time -= 0.1
