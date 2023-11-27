extends CharacterBody2D

const SPEED = 100
const STARTX = 120

var preMissile = preload("res://Scenes/Player/Missile.tscn")
var missile = null
var lives = 3
var exploding = false

@onready var animatedSprite = $AnimatedSprite2D

func _physics_process(delta):
	_animate()
	if !exploding: _controls(delta)
	move_and_slide()

func _animate():
	if animatedSprite.animation=="explode":
		if !animatedSprite.is_playing():
				exploding= false
				animatedSprite.play("idle")
				_reset()

func _controls(delta):
	if Input.is_action_pressed("move_left"):
		if position.x>20: position.x -= SPEED * delta
	elif Input.is_action_pressed("move_right"):
		if position.x<180:position.x += SPEED * delta
	elif Input.is_action_just_pressed("shoot"):
		_shoot()

func _reset():
	position.x = STARTX

func _shoot():
	#Solo puede haber un misil al mismo tiempo
	if missile == null:
		missile = preMissile.instantiate()
		missile.position = position + Vector2(0,-12) # Diferencia trompa de la nave
		get_parent().call_deferred("add_child", missile)

func _hit():
	lives -= 1
	exploding= true
	animatedSprite.play("explode")
	if lives <=0: print ("END GAME")

func _on_hitbox_body_entered(body):
	if body.get_parent().name == "Enemies":
		body._reset()
		_hit()
