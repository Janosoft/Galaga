extends CharacterBody2D

const SPEED = 300

func _physics_process(delta):
	_move(delta)
	
func _move(delta):
	position.y -= SPEED * delta
	if position.y <=0: _destroy()

func _destroy():
	queue_free()
