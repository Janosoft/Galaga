extends CharacterBody2D

signal died

const SPEED = 100
const STARTX = 120
var canShoot= true
var preMissile = preload("res://Scenes/Player/PlayerMissile.tscn")
var lives = 3
var exploding = false

@onready var animatedSprite = $AnimatedSprite2D
@onready var screensize = get_viewport_rect().size

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
	var direction = Input.get_axis("move_left", "move_right")
	position.x += direction * SPEED * delta
	position.x= clamp(position.x, 16, screensize.x - 16) #Agrega un limite para que no se salga de la pantalla
	if Input.is_action_just_pressed("shoot"): _shoot()

func _reset():
	position.x = STARTX

func _shoot():
	if canShoot:
		canShoot= false
		var missile = preMissile.instantiate()
		missile.position = position + Vector2(0,-12) # Diferencia trompa de la nave
		get_tree().root.add_child(missile)
		$GunCooldown.start()

func _hit():
	lives -= 1
	exploding= true
	animatedSprite.play("explode")
	if lives <=0: died.emit()

func _on_hitbox_body_entered(body):
	if body.get_parent().name == "Enemies":
		body._reset()
		_hit()
	elif body.name == "EnemyMissile":
		body.destroy() #Destoy Missile
		_hit()

func _on_gun_cooldown_timeout():
	canShoot= true
