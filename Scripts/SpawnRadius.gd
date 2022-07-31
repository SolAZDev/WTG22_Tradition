extends Area2D

export var Enemies: Array = Array()
onready var timer: Timer = $Timer
export(int) var waitTime=4

func onEnter(body): _on_Area2D_body_entered(body)
func _on_Area2D_body_entered(body):
	if body.name == 'Player':
		print('Player Detected!')
		timer.start(waitTime)

func onExit(body): _on_Area2D_body_exited(body)
func _on_Area2D_body_exited(body):
	if body.name == 'Player':
		print('Player Left!')
		timer.stop()

func _on_Timer_timeout(): _on_SpawnTimer_timeout()
func _on_SpawnTimer_timeout():
	print('Timeout!')
	var random = RandomNumberGenerator.new()
	random.randomize()	
	var spawn = Enemies[random.randi_range(0,Enemies.size()-1)].instance()
	get_tree().get_root().add_child(spawn)
	spawn.global_position = global_position
