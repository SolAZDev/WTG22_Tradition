class_name Player
extends Actor

#const bulletPath = preload('res://Scenes/Bullet.tscn')
export(PackedScene) var bulletPath 
export(AudioStream) var itemGet
export(AudioStream) var throw
export(AudioStream) var hurt

var bulletAmmo = 5

var IsPlayerDead = false
var canShoot:bool=true
var canDash:bool=true
var itemPickup: Area2D = null
onready var offsetParent: Node2D = $offsetRotator
onready var bulletOffset: Node2D = get_node("offsetRotator/ShootOffset")
onready var ShootCaster: RayCast2D = get_node("offsetRotator/RayCast2D")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
		
func _process(delta):
	offsetParent.look_at(global_position+vel)
	if Input.is_action_just_pressed("attack") && shootCastAlt():
		if bulletAmmo > 0:
			updateAmmo(-1)
			shoot()
	#if Input.is_action_just_pressed("dodge") && canDash:
		#speed*=2
		
		
func shoot():
	var bullet = bulletPath.instance()
	get_parent().add_child(bullet)
	bullet.position = bulletOffset.global_position
	bullet.Velocity = Vector2(1,0).rotated(offsetParent.rotation)
	if throw!=null: AudioManager.playSound(throw)

func _physics_process(delta):
	moveKeys()
	move_and_slide(vel*speed)
	for i in get_slide_count():
		var col = get_slide_collision(i)

func shootCast():
	var res:Dictionary = get_world_2d().direct_space_state.intersect_ray(bulletOffset.global_position, bulletOffset.global_position*Vector2(1,0))
	if !res.empty():
		return res.collider is TileMap 
	return false
	
func shootCastAlt():
	if ShootCaster.is_colliding(): 
		print(ShootCaster.get_collider().get_class())
		if ShootCaster.get_collider() is TileMap: return false
	return true
	
func onHealthChange():
	if health == 0 || health < 0: speed=0
	else: speed=200

func moveKeys():
	if Input.is_action_pressed("mv_up"): 
		vel=Vector2(0,-1)
		spr.animation="mv_up"
	elif Input.is_action_pressed("mv_down"): 
		vel=Vector2(0,1)
		spr.animation="mv_down"
	elif Input.is_action_pressed("mv_left"): 
		vel=Vector2(-1,0)
		spr.flip_h=false
		spr.animation="mv_left"
	elif Input.is_action_pressed("mv_right"): 
		vel=Vector2(1,0)
		spr.flip_h=true
		spr.animation="mv_left"
	else:
		if vel.y<0: spr.animation="idle_up"
		elif vel.y>0: spr.animation="idle_dw"
		elif vel.x<0: spr.animation="idle_left"
		elif vel.x>0: spr.animation="idle_left"
		#idle
		vel=Vector2(0,0)
		
func updateAmmo(num):
	bulletAmmo+=num			
	hud.BulletCount(bulletAmmo)
	if itemGet!=null: AudioManager.playSound(itemGet)
