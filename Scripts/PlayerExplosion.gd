extends StaticBody2D

@onready var animatedSprite = $AnimatedSprite2D

func _physics_process(delta):
	if animatedSprite.animation=="explode":
		if !animatedSprite.is_playing(): queue_free()
