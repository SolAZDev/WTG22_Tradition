extends Area2D

var Velocity = Vector2(1,0)
export(float) var Speed = 2
export(float) var SpeedOverTime=.25
export(bool) var enableNeagtive=false;
export(bool) var isEnemy=false
var shooting:bool = true

export(NodePath) var pickupParticle: NodePath
export(PackedScene) var hitAnim: PackedScene
export(AudioStream) var hitEnemy
export(AudioStream) var hitSolid

onready var trueSpeed=Speed;
func _ready():
	pass
	
func _process(delta):
	if shooting:
		trueSpeed+=SpeedOverTime
		if !enableNeagtive && trueSpeed<=0: 
			trueSpeed=0
			shooting=false
		translate(Velocity*trueSpeed)
	
func onBodyEnter(node: Node2D):
	#print(node.name,"!")
	if shooting:
		if hitAnim != null: 
			var p =hitAnim.instance()
			get_parent().add_child(p)
			p.position = global_position
		if node is Boss:
			node.Hurt(self)
			if hitEnemy != null: AudioManager.playSound(hitEnemy)
		if node is Actor:
			node.updateHealth(-1)
			if hitEnemy != null: AudioManager.playSound(hitEnemy)
		else: if hitSolid != null: AudioManager.playSound(hitSolid)
		shooting=false
		if !isEnemy:
			var par=get_node(pickupParticle)
			par.emitting=true
		else: queue_free()
	else: 
		if node.name == "Player": 
			node.updateAmmo(1)
			queue_free()

func _on_Disk_body_entered(node:Node2D): onBodyEnter(node)
