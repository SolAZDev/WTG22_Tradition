class_name SpawnRadius
extends Area2D

export var Enemies: Array = Array()
onready var timer: Timer = $Timer
export(int) var waitTime=4
export(bool) var canRun=true

func stopTimer(): timer.stop()
func startTimer(): timer.start(waitTime)

func onEnter(body):
	if body is Player && canRun:
		print('Player Detected!')
		timer.start(waitTime)

func onExit(body): 
	if body is Player:
		print('Player Left!')
		timer.stop()

func _on_Timer_timeout():
	print('Timeout!')
	var random = RandomNumberGenerator.new()
	random.randomize()	
	var spawn = Enemies[random.randi_range(0,Enemies.size()-1)].instance()
	get_tree().get_root().add_child(spawn)
	spawn.global_position = global_position
