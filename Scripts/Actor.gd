class_name Actor
extends KinematicBody2D

export(int) var health = 1
export(int) var speed = 200
export(PackedScene) var killAnim: PackedScene
var vel: Vector2 = Vector2()
onready var spr: AnimatedSprite = $AnimatedSprite
onready var hud = get_parent().get_node("HUD")

func updateHealth(ammount:int):
	health+=ammount
	if name != "Player": #Do Custom Handling
		if health<=0:
			if killAnim!=null:
				var a = killAnim.instance()
				get_parent().add_child(a)
				a.position = global_position
			queue_free()
	else: hud.HealthCount(health)
				
