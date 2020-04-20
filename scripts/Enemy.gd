extends Node2D

var health = 3
var target
var direction
var moveSpeed = 0

func _ready():
	target = $"../Player/Unicorn"
	moveSpeed = rand_range(0.5, 1) * 100

func _process(delta):
	direction = global_position.direction_to(target.global_position)
	position += direction * moveSpeed * delta
	if health <= 0:
		globals.score += 10 * globals.multiplier
		queue_free()

func _on_Area_area_entered(area):
	if area.is_in_group("bullet"): 
		health -= 1
		area.get_parent().queue_free()
	elif area.is_in_group("unicorn"):
		area.get_parent().loseHealth()
		queue_free()
