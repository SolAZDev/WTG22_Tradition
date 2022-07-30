extends KinematicBody2D

var Velocity = Vector2(1,0)
var Speed = 300

func _physics_process(delta):
	
	var collision_info = move_and_collide(Velocity.normalized() * delta * Speed)
