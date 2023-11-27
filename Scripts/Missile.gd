extends CharacterBody2D

const SPEED = 5

func _physics_process(delta):
	_move()
	
func _move():
	position.y -= SPEED
	if position.y <=0: _destroy()

func _destroy():
	queue_free()
