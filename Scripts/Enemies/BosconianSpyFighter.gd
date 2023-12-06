extends CharacterBody2D

signal died

var start_pos= Vector2.ZERO
var speedMin= 50
var speedMax= 75
var moveTimerMin= 5
var moveTimerMax= 20
var shootTimerMin= 4
var shootTimerMax= 20
var lives= 1
var points= 5

var speed= 0
var exploding= false
@onready var viewportSize= get_viewport().content_scale_size
@onready var animatedSprite= $AnimatedSprite2D

func start(pos):
	speed = 0
	position = Vector2(pos.x, -pos.y)
	start_pos = pos
	$MoveTimer.wait_time = randf_range(moveTimerMin,moveTimerMax)
	$MoveTimer.start()
	$ShootTimer.wait_time = randf_range(shootTimerMin,shootTimerMax)
	$ShootTimer.start()

func _physics_process(delta):
	if !exploding: _move(delta)

func _move(delta):
	position.y += speed * delta
	if position.y > viewportSize.y: position.y= start_pos.y

func _on_hitbox_body_entered(body):
	if body.name == "PlayerMissile":
		body.destroy() #Destoy Missile
		_hit()

func _hit():
	lives -=1
	if lives <=0: _destroy()

func _destroy():
	speed = 0
	exploding= true
	animatedSprite.play("explode")
	set_deferred("monitorable", false)
	died.emit(points)
	await animatedSprite.animation_finished
	queue_free()
	
func _reset():
	position.y= 20

func _on_move_timer_timeout():
	speed = randf_range(speedMin, speedMax)

func _on_shoot_timer_timeout():
	_shoot()
	$ShootTimer.wait_time = randf_range(shootTimerMin,shootTimerMax)
	$ShootTimer.start()

func _shoot():
	pass
