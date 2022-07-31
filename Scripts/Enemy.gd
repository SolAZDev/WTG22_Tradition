extends Actor

onready var player= get_node('/root/Node2D/Player')
var IsPlayerHit = false
export(bool) var killOnTouch: bool=false
export(int) var detectRadius:int=500

func _ready():
	vel = move_and_slide(vel)

func _physics_process(delta):
	if global_position.distance_to(player.global_position)<=detectRadius:
		var playerdirection = (player.global_position - global_position).normalized()
		spr.flip_h=playerdirection.x>0
		move_and_slide(playerdirection * speed)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider == player:
			if IsPlayerHit == false:
				IsPlayerHit = true
				player.updateHealth(-1)
				print("Player got hit! Life: ", player.health)
				if killOnTouch: updateHealth(-10000)
		else: IsPlayerHit=false
		
