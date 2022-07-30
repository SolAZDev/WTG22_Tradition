extends KinematicBody2D

const bulletPath = preload('res://Scenes/Bullet.tscn')
#export(NodePath) var bulletPath

export(int) var speed = 200
var vel: Vector2 = Vector2()
onready var anim = $Sprite


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		print('SHOOTING')
		shoot()
		
	look_at(get_global_mouse_position())

func shoot():
	var bullet = bulletPath.instance()
	
	add_child(bullet)
	bullet.position = $Position2D.position
	
	bullet.Velocity = get_global_mouse_position() - bullet.position

func _physics_process(delta):
	vel = Vector2(Input.get_axis("ui_left","ui_right"),Input.get_axis("ui_up","ui_down"));
	move_and_slide(vel*speed)
	
func _input_event(viewport, event, shape_idx):
	if(vel.x > 0): anim.rotation=90
	if(vel.x < 0): anim.rotation=270
	if(vel.y > 0): anim.rotation=0
	if(vel.y < 0): anim.rotation=180
