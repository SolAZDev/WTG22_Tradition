extends CanvasLayer



onready var life: Label = $LifeBOX/LifeCount
onready var throwable: Label = $ThrowableBOX/ThrowableCount

func HealthCount(ammount):
	var hp:String = ""
	for i in ammount:
		hp+="o"
	life.text=hp

func BulletCount(ammount):
	var bul:String = ""
	for i in ammount:
		bul+="o"
	throwable.text=bul
