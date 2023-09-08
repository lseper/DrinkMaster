class_name PausePanel extends Sprite2D

@onready var main_panel = $MainPanel
@onready var credits_panel = $CreditsPanel
@onready var exit_warning_panel = $ExitWarningPanel

func return_to_main_panel():
	hide_panels()
	main_panel.show()

func hide_panels():
	main_panel.hide()
	credits_panel.hide()
	exit_warning_panel.hide()

func resume():
	hide()
	get_tree().paused = false

# Called when the node enters the scene tree for the first time.
func _ready():
	main_panel.show()
	credits_panel.hide()
	exit_warning_panel.hide()

func _input(event):
	if event.is_action_pressed("pause"):
		resume()

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
