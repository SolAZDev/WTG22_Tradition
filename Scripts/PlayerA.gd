extends Actor

#const bulletPath = preload('res://Scenes/Bullet.tscn')
export(PackedScene) var bulletPath 
var bulletAmmo = 5
var playerHealth = 5
var IsPlayerDead = false

#export(NodePath) var bulletPath

onready var bulletOffset: Position2D = $ShootOffset
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	if Input.is_action_just_pressed("attack"):
		if bulletAmmo > 0:
			bulletAmmo = bulletAmmo - 1
		else:
			bulletAmmo = bulletAmmo
		
		print('SHOOTING! Ammo: ' , bulletAmmo)
		shoot()
	
	if Input.is_action_just_pressed("debug_ammoplus"):
		bulletAmmo = bulletAmmo + 1
		print('Bullets Increased! Ammo: ' , bulletAmmo)
	
	if Input.is_action_just_pressed("debug_heal"):
		playerHealth = playerHealth + 1
		print('Health Increased! Life: ' , playerHealth)
	
	if Input.is_action_just_pressed("debug_hurt"):
		playerHealth = playerHealth - 1
		print('Health Decreased! Life: ' , playerHealth)
	
	look_at(get_global_mouse_position())
	
	if playerHealth == 0 || playerHealth < 0:
		IsPlayerDead = true	
	else:
		IsPlayerDead = false
	
	if IsPlayerDead == true:
		speed = 0
	else:
		speed = 200

func shoot():
	if bulletAmmo > 0:
		var bullet = bulletPath.instance()
		get_parent().add_child(bullet)
		bullet.position = bulletOffset.global_position
		bullet.Velocity = (get_global_mouse_position() - position).normalized()

func _physics_process(delta):
	vel = Vector2(Input.get_axis("mv_left","mv_right"),Input.get_axis("mv_up","mv_down"));
	move_and_slide(vel*speed)


