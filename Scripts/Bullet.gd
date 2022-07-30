extends KinematicBody2D

var Velocity = Vector2(1,0)
var Speed = 500

func _physics_process(delta):
	move_and_collide(Velocity.normalized() * delta * Speed)
