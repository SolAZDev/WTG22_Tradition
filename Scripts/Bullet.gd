extends Area2D

var Velocity = Vector2(1,0)
export(float) var Speed = 2
export(float) var SpeedOverTime=.25
export(bool) var enableNeagtive=false;
var shooting:bool = true

onready var trueSpeed=Speed;

func _process(delta):
	if shooting:
		trueSpeed+=SpeedOverTime
		if !enableNeagtive && trueSpeed<=0: trueSpeed=0
		translate(Velocity*trueSpeed)
	
func _body_entered(node):
	print(node, "?")

func _on_Disk_body_entered(node:Node2D):
	print(node.name,"!")
	shooting=false
	#play hit animation?
	
