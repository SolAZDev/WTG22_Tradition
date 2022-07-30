extends Actor

const bulletPath = preload('res://Scenes/Bullet.tscn')
var bulletAmmo = 5

#export(NodePath) var bulletPath

onready var bulletOffset: Position2D = $ShootOffset
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		if bulletAmmo > 0:
			bulletAmmo = bulletAmmo - 1
		else:
			bulletAmmo = bulletAmmo
		
		print('SHOOTING! Ammo: ' , bulletAmmo)
		shoot()
		
	look_at(get_global_mouse_position())

func shoot():
	if bulletAmmo > 0:
		var bullet = bulletPath.instance()
		get_parent().add_child(bullet)
		bullet.position = bulletOffset.global_position
		bullet.Velocity = get_global_mouse_position() - position

func _physics_process(delta):
	vel = Vector2(Input.get_axis("ui_left","ui_right"),Input.get_axis("ui_up","ui_down"));
	move_and_slide(vel*speed)
	

