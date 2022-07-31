extends KinematicBody2D

export var Healths: Array = [4, 6, 8]
export var SpawnObject: Array = [NodePath(),NodePath(),NodePath()]
export var RunningSprite: Array = [NodePath(),NodePath(),NodePath()]

var CurrentHealth:int=1
var activePhase:int = -1

func _ready():
	for i in SpawnObject: SpawnObject[i].get_node(0).set_process(false)

func changePhase():
	if Healths[activePhase+1]==null: DestroyAll()
	SpawnObject[activePhase].get_node().set_pProcess(false)
	RunningSprite[activePhase].get_node().set_process(false)
	activePhase+=1
	CurrentHealth=Healths[activePhase]
	SpawnObject[activePhase].get_node().set_process(true)
	RunningSprite[activePhase].get_node().set_process(true)
	
func DestroyAll():
	queue_free()

