extends CanvasLayer

onready var life: Label = $LifeBOX/LifeCount
onready var throwable: Label = $ThrowableBOX/ThrowableCount


func _ready():
	HealthCount(1)
	
func HealthCount(ammount):
	var val:String = ""
	for i in ammount:
		val+="o"
		life.text=val

func BulletCount(ammount):
	var val:String = ""
	for i in ammount:
		val+="o"
		throwable.text=val
