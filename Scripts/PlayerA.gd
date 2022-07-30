extends Actor

#const bulletPath = preload('res://Scenes/Bullet.tscn')
export(PackedScene) var bulletPath 
var bulletAmmo = 5
var playerHealth = 5
var IsPlayerDead = false
var itemPickup: Area2D = null
onready var offsetParent: Node2D = $offsetRotator
onready var bulletOffset: Position2D = offsetParent.get_child(0)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	offsetParent.look_at(get_global_mouse_position())
	if Input.is_action_just_pressed("attack"):
		if bulletAmmo > 0:
			bulletAmmo = bulletAmmo - 1
			print('SHOOTING! Ammo: ' , bulletAmmo)
			shoot()
		#$else:
			#bulletAmmo = bulletAmmo
		
	if Input.is_action_just_pressed("interact"):
		if itemPickup!=null:
			itemPickup.queue_free()
			itemPickup=null
			bulletAmmo=bulletAmmo+1
			print("picked up G U N", bulletAmmo)
	# if Input.is_action_just_pressed("debug_ammoplus"):
	# 	bulletAmmo = bulletAmmo + 1
	# 	print('Bullets Increased! Ammo: ' , bulletAmmo)
	
	# if Input.is_action_just_pressed("debug_heal"):
	# 	playerHealth = playerHealth + 1
	# 	print('Health Increased! Life: ' , playerHealth)
	
	# if Input.is_action_just_pressed("debug_hurt"):
	# 	playerHealth = playerHealth - 1
	# 	print('Health Decreased! Life: ' , playerHealth)
	
	
	if playerHealth == 0 || playerHealth < 0:
		IsPlayerDead = true	
	else:
		IsPlayerDead = false
	
	if IsPlayerDead == true:
		speed = 0
	else:
		speed = 200

func shoot():
	var bullet = bulletPath.instance()
	get_parent().add_child(bullet)
	bullet.position = bulletOffset.global_position
	bullet.Velocity = (get_global_mouse_position() - position).normalized()

func _physics_process(delta):
	vel = Vector2(Input.get_axis("mv_left","mv_right"),Input.get_axis("mv_up","mv_down"));
	move_and_slide(vel*speed)
	for i in get_slide_count():
		var col = get_slide_collision(i)
		#print(get_slide_count(), col.collider.name)


