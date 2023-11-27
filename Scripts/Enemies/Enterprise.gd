extends CharacterBody2D

const SPEED = 50
const STARTY = 20

var lives = 1
var exploding = false
@onready var viewportSize = get_viewport().content_scale_size
@onready var animatedSprite = $AnimatedSprite2D

func _physics_process(delta):
	_animate()
	if !exploding: _move(delta)

func _animate():
	if animatedSprite.animation=="explode":
		if !animatedSprite.is_playing():
				queue_free()
	else:
		animatedSprite.play("idle")

func _move(delta):
	position.y += SPEED * delta
	if position.y > viewportSize.y: position.y= STARTY

func _on_hitbox_body_entered(body):
	if body.name == "PlayerMissile":
		body._destroy() #Destoy Missile
		_hit()

func _hit():
	lives -=1
	if lives <=0: _destroy()

func _destroy():
	exploding= true
	animatedSprite.play("explode")

func _reset():
	position.y= 20
