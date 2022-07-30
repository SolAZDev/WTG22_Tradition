extends Particles2D

func _ready():
	one_shot=true;
	var t = Timer.new()
	t.one_shot=true
	t.set_wait_time(1)
	add_child(t)
	yield(t,"timeout")
	queue_free()
