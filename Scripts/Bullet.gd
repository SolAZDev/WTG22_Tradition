extends Area2D

var Velocity = Vector2(1,0)
export(float) var Speed = 2
export(float) var SpeedOverTime=.25
export(bool) var enableNeagtive=false;
export(bool) var isEnemy=false
var shooting:bool = true

export(NodePath) var pickupParticle: NodePath

onready var trueSpeed=Speed;

func _process(delta):
	if shooting:
		trueSpeed+=SpeedOverTime
		if !enableNeagtive && trueSpeed<=0: 
			trueSpeed=0
			shooting=false
		translate(Velocity*trueSpeed)
	
func onBodyEnter(node: Node2D):
	shooting=false
	print(node.name,"!")
	match node.name:
		"Player": 
			node.itemPickup = self
			node.health-=1;

func _on_Disk_body_entered(node:Node2D): onBodyEnter(node)
