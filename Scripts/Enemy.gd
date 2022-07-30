extends Actor

onready var player = get_parent().get_node('Player')
var IsPlayerHit = false
export(bool) var killOnTouch: bool=false

func _ready():
	vel = move_and_slide(vel)

func _physics_process(delta):
	var playerdirection = (player.global_position - global_position).normalized()
	move_and_slide(playerdirection * speed)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider == player:
			if IsPlayerHit == false:
				IsPlayerHit = true
				player.health = player.health - 1
				print("Player got hit! Life: ", player.health)
				if killOnTouch: updateHealth(-10000)
