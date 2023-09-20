class_name ComboLabel extends Label

@onready var base_font_size = label_settings.font_size

func set_blink(combo: int):
	if combo == 0:
		visible = false
	else:
		visible = true
		text = "x " + str((1.0 + (combo / 10.0)))
		label_settings.font_size = clamp(base_font_size + (combo * 3), base_font_size, 64)
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
