extends Actor

#const bulletPath = preload('res://Scenes/Bullet.tscn')
export(PackedScene) var bulletPath 
var bulletAmmo = 5

var IsPlayerDead = false
var canShoot=true
var itemPickup: Area2D = null
onready var offsetParent: Node2D = $offsetRotator
onready var bulletOffset: Area2D = offsetParent.get_child(0)
onready var anim: AnimatedSprite = $AnimatedSprite
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _process(delta):
	offsetParent.look_at(global_position+vel)
	if Input.is_action_just_pressed("attack") && canShoot:
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
	# 	health = health + 1
	# 	print('Health Increased! Life: ' , health)
	
	# if Input.is_action_just_pressed("debug_hurt"):
	# 	health = health - 1
	# 	print('Health Decreased! Life: ' , health)
	
	

func shoot():
	var bullet = bulletPath.instance()
	get_parent().add_child(bullet)
	bullet.position = bulletOffset.global_position
	#bullet.Velocity = (get_global_mouse_position() - position).normalized()
	bullet.Velocity = Vector2(1,0).rotated(offsetParent.rotation)

func _physics_process(delta):
	#vel = Vector2(Input.get_axis("mv_left","mv_right"),Input.get_axis("mv_up","mv_down"));
	moveKeys()
	move_and_slide(vel*speed)
	for i in get_slide_count():
		var col = get_slide_collision(i)
		#print(get_slide_count(), col.collider.name)


func onShootCheckEnter(node: Area2D): if shootCast(): canShoot=false
func onShootCheckExit(node: Node2D): if shootCast(): canShoot=true

func shootCast():
	var res = get_world_2d().direct_space_state.intersect_ray(bulletOffset.global_position, bulletOffset.global_position*Vector2(1,0))
	#if res: print("Hit a point: ",res.position, res.collider is TileMap)
	return res.collider is TileMap

func onHealthChange():
	if health == 0 || health < 0:
		IsPlayerDead = true	
	else:
		IsPlayerDead = false
	
	if IsPlayerDead == true:
		speed = 0
	else:
		speed = 200

func moveKeys():
	if Input.is_action_pressed("mv_up"): 
		vel=Vector2(0,-1)
	elif Input.is_action_pressed("mv_down"): 
		vel=Vector2(0,1)
	elif Input.is_action_pressed("mv_left"): 
		vel=Vector2(-1,0)
		anim.flip_h=false
	elif Input.is_action_pressed("mv_right"): 
		vel=Vector2(1,0)
		anim.flip_h=true
	else:
		vel=Vector2(0,0)
