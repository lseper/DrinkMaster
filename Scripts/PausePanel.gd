class_name PausePanel extends Sprite2D

@onready var main_panel = $MainPanel
@onready var credits_panel = $CreditsPanel
@onready var exit_warning_panel = $ExitWarningPanel
@onready var help_panel = $HelpPanel
@onready var results_panel = $ResultsPanel

signal game_unpaused()

func return_to_main_panel():
	hide_panels()
	main_panel.show()

func hide_panels():
	main_panel.hide()
	credits_panel.hide()
	exit_warning_panel.hide()
	help_panel.hide()
	results_panel.hide()

func resume():
	game_unpaused.emit()
	hide()
	get_tree().paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	hide_panels()
	help_panel.show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_back_button_pressed():
	resume()

func _on_exit_button_pressed():
	hide_panels()
	exit_warning_panel.show()

func _on_credits_button_pressed():
	hide_panels()
	credits_panel.show()

func _on_no_button_pressed():
	return_to_main_panel()

func _on_credits_back_button_pressed():
	return_to_main_panel()

func _on_yes_button_pressed():
	get_tree().quit()

func _on_help_button_pressed():
	hide_panels()
	help_panel.show()

func _on_help_back_button_pressed():
	return_to_main_panel()

func _on_start_button_pressed():
	hide_panels()
	main_panel.show()
	resume()

func _on_game_manager_game_over(_drinks_total: float, _tips_total: float, _bonus_total: float):
	hide_panels()
	results_panel.show()

func _on_results_panel_resume():
	return_to_main_panel()
	resume()
