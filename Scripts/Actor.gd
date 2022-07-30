class_name Actor
extends KinematicBody2D

export(int) var health = 1
export(int) var speed = 200
var vel: Vector2 = Vector2()
onready var spr: AnimatedSprite = $AnimatedSprite
export(PackedScene) var killAnim: PackedScene


func updateHealth(ammount:int):
	health+=ammount
	if name != "Player": #Do Custom Handling
		if health<=0:
			if killAnim!=null:
				var a = killAnim.instance()
				get_parent().add_child(a)
				a.position = global_position
			queue_free()
