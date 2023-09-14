class_name HelpPanel extends Node2D

@onready var name_entry = $LineEdit
@onready var start_button = $StartButton

signal set_name(name: String)

func set_username(username: String):
	set_name.emit(username)
	start_button.visible = true
	start_button.disabled = false

func disable_start():
	start_button.visible = false
	start_button.disabled = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_line_edit_text_submitted(new_text):
	if new_text.length() > 0:
		set_username(new_text)


func _on_line_edit_text_changed(new_text):
	if new_text.length() == 0:
		disable_start()
