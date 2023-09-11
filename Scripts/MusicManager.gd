class_name MusicManager extends Node2D

# NOTE: If you are implementing pausing in the game, be sure to set this node's
# process mode to "Always"!

@onready var intro_music = $IntroMusic
@onready var game_loop_music = $GameLoopMusic
@onready var death_music = $DeathMusic
@onready var ingredient_success = $IngredientSuccessSFX
@onready var ingredient_failure = $IngredientFailureSFX

func play_death_music():
	_stop_all_tracks()
	death_music.play()

func _stop_all_tracks():
	intro_music.stop()
	game_loop_music.stop()
	death_music.stop()

func play_pause_menu_theme():
	_stop_all_tracks()
	intro_music.play()
	
func play_main_theme():
	_stop_all_tracks()
	game_loop_music.play()

# Called when the node enters the scene tree for the first time.
func _ready():
	play_main_theme()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_game_manager_game_paused():
	play_pause_menu_theme()

func _on_pause_panel_game_unpaused():
	play_main_theme()

func _on_health_bar_health_depleted():
	play_death_music()

func _on_health_bar_damage_taken():
	ingredient_failure.play()


func _on_game_manager_money_earned(_base: float, _tip : float):
	ingredient_success.play()
