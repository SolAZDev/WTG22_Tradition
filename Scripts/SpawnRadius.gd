extends Area2D

onready var timer: Timer = $SpawnTimer

func _on_Area2D_body_entered(body):
	if body.name == 'Player':
		print('Player Detected!')
		timer.start()

func _on_Area2D_body_exited(body):
	if body.name == 'Player':
		print('Player Left!')
		timer.stop()

func _on_SpawnTimer_timeout():
	print('Timeout!')

