class_name Actor
extends KinematicBody2D

export(int) var health = 1
export(int) var speed = 200
var vel: Vector2 = Vector2()
onready var spr: AnimatedSprite = $AnimatedSprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
