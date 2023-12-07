extends CharacterBody2D

const SPEED = -150

func _physics_process(delta):
	_move(delta)
	
func _move(delta):
	position.y -= SPEED * delta

func destroy():
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():
	destroy()
