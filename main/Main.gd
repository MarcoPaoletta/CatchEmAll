extends Node2D
const BASIC_LEVEL = 5
const BONUS_TIME = 5
export (PackedScene) var Gem 
var score = 0
var level = 0
var time_left = 0
var Cherry = preload("res://gem/Cherry.tscn")
onready var GameOverT = Timer.new()

func _ready():
	$HUD/GameOverL.visible = false
	timer_settings()
	time_left = 30
	$HUD.update_timer(time_left)
	OS.center_window()
	randomize()
	spawn_gems()
	set_cherry_timer()
	$Froggy.visible = true
	
func timer_settings():
	GameOverT.wait_time = 2
	GameOverT.connect("timeout", self, "_onGameOverT_timeout")
	add_child(GameOverT)
	
func _onGameOverT_timeout():
	get_tree().change_scene("res://menu/Menu.tscn")

func update_platform_position():
	$Platform.position.x = $Froggy.position.x
	
func _process(delta):
	update_platform_position()
	if $GemContainer.get_child_count() == 0:
		$LevelAudio.play()
		level += 1
		time_left += BONUS_TIME
		spawn_gems()
	
func spawn_gems():
	for index in range(BASIC_LEVEL + level):
		var G = Gem.instance()
		G.position = Vector2(rand_range(0,480),rand_range(0,720))
		$GemContainer.add_child(G)

func game_over():
	$GameT.stop()
	$HUD/GameOverL.visible = true
	$Player.game_over()
	GameOverT.start()
	

func _on_GameT_timeout():
	time_left -= 1
	$HUD.update_timer(time_left)
	if time_left <= 0:
		$GameT.stop()
		game_over()

func _on_Player_picked(type):
	match type:
		"gem":
			score += 1
			$HUD.update_score(score)
		"cherry":
			time_left += 5
			$HUD.update_timer(time_left)
			
func set_cherry_timer():
	var interval = rand_range(5,10)
	$CherryT.wait_time = interval
	$CherryT.start()

func _on_CherryT_timeout():
	$CherryT.stop()
	var cherry = Cherry.instance()
	cherry.position.x = rand_range(25,460)
	cherry.position.y = rand_range(25,700)
	$GemContainer.add_child(cherry)
	set_cherry_timer()

func _on_Player_hurt():
	game_over()
