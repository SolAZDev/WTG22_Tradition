class_name Boss 
extends KinematicBody2D

export(Array,int) var Healths: Array = [4, 6, 8]
export(Array, NodePath) var SpawnObject: Array
export(Array, NodePath) var RunningSprite: Array

var CurrentHealth:int=1
var activePhase:int = -1

var player

func _ready():
	disableEverythingAtStart()
	player=get_tree().get_root().find_node("Player", true, false)
	
func disableEverythingAtStart():
	print(SpawnObject.size())
	if(SpawnObject.size()>0):
		for sonp in SpawnObject:
			var sp = get_node(sonp)
			sp.canRun=false
			#for child in sp.get_children():
			#	if !(child is Timer):
			#		child.set_process(false)
			#		child.hide()
			sp.set_process(false)
			sp.hide()


func changePhase():
	if Healths.size()<=activePhase+1: 
		DestroyAll()
		pass
	else:
		var curr=get_node(SpawnObject[activePhase]) as SpawnRadius
		curr.canRun=false
		curr.stopTimer()
		#curr.set_process(false)
		#curr.hide()
		get_node(RunningSprite[activePhase]).hide()
		activePhase+=1
		curr=get_node(SpawnObject[activePhase]) as Area2D
		CurrentHealth=Healths[activePhase]
		curr.canRun=true
		curr.startTimer()
		curr.show()
		curr.set_process(true)
		get_node(RunningSprite[activePhase]).show()
	
func DestroyAll():
	queue_free()

func Hurt(node:Area2D):
	print("HEY! That hurts!!")
	node.queue_free()
	player.updateAmmo(1)
	CurrentHealth-=1
	if CurrentHealth<=0: changePhase()
	
