extends Node2D

const ENEMYTYPETEST= "res://Scenes/Enemies/BosconianSpyFighter.tscn"
const ENEMYTYPE1= "res://Scenes/Enemies/Goei.tscn"
const ENEMYTYPE2= "res://Scenes/Enemies/BossGalaga.tscn"

var score = 0
var playing = false

func _ready():
	_new_game()

func _process(_delta):
	if playing and $Enemies.get_child_count() == 0:
		print ("PASAR DE NIVEL")
		playing= false

func _new_game():
	score = 0
	_spawn_enemies()
	playing = true

func _spawn_enemies():
	var enemy= preload(ENEMYTYPETEST)
	var e = enemy.instantiate()
	var pos = Vector2(40, 30)
	$Enemies.add_child(e)
	e.start(pos)
	
	enemy= preload(ENEMYTYPE2)
	e = enemy.instantiate()
	pos = Vector2(120, 30)
	$Enemies.add_child(e)
	e.start(pos)

func _on_enemy_died(value):
	score += value
	print (score)

func _on_player_died():
	print("GAME OVER")
	playing = false
