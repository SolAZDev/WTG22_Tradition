extends Area2D

var Velocity = Vector2(1,0)
export(float) var Speed = 2
export(float) var SpeedOverTime=.25
export(bool) var enableNeagtive=false;
export(bool) var isEnemy=false
var shooting:bool = true

export(NodePath) var pickupParticle: NodePath
export(PackedScene) var hitAnim: PackedScene

onready var trueSpeed=Speed;

func _process(delta):
	if shooting:
		trueSpeed+=SpeedOverTime
		if !enableNeagtive && trueSpeed<=0: 
			trueSpeed=0
			shooting=false
		translate(Velocity*trueSpeed)
	
func onBodyEnter(node: Node2D):
	print(node.name,"!")
	if shooting:
		print((node is Actor))
		if node is Actor:
			node.updateHealth(-1)
			#emit hit particle?
		else:
			shooting=false
			if hitAnim != null: 
				var p =hitAnim.instance()
				get_parent().add_child(p)
				p.position = global_position
			var par=get_node(pickupParticle)
			par.emitting=true
	else: 
		if node.name == "Player": 
			node.bulletAmmo+=1
			request_ready()

func _on_Disk_body_entered(node:Node2D): onBodyEnter(node)
