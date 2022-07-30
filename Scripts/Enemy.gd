extends Actor

onready var player = get_parent().get_node('Player')
var IsPlayerHit = false
export(PackedScene) var killAnimation: PackedScene

func _ready():
	vel = move_and_slide(vel)

func _physics_process(delta):
	var playerdirection = (player.global_position - global_position).normalized()
	move_and_slide(playerdirection * speed)
	
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		print("I collided with ", collision.collider.name)
		
		if collision.collider == player:
			if IsPlayerHit == false:
				IsPlayerHit = true
				player.health = player.health - 1
				print("Player got hit! Life: ", player.health)
			if killAnimation!=null: get_parent().add_child(killAnimation.instance())
			queue_free()
