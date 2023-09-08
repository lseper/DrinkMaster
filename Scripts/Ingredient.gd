class_name Ingredient extends Sprite2D

signal mix_attempted(successful : bool)

@onready var exit_behaviour = $ExitBehaviour

enum IngredientType {
	RUM,
	WINE,
	SODA,
	VODKA,
	ICE
}

var processable_inputs = [KEY_A, KEY_W, KEY_D, KEY_S, KEY_UP, KEY_LEFT, KEY_RIGHT, KEY_DOWN, KEY_SPACE]

var ingredient_to_key_press_map := {
	IngredientType.RUM : "ui_left",
	IngredientType.WINE : "ui_down",
	IngredientType.SODA : "ui_up",
	IngredientType.VODKA : "ui_right",
	IngredientType.ICE : "ui_select"
}

@export var ingredient_type : IngredientType

func mix_correctly():
	exit_behaviour.exit()
	mix_attempted.emit(true)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _get_mix_key():
	return ingredient_to_key_press_map.get(ingredient_type)

func _is_processable(event):
	if event is InputEventKey:
		return processable_inputs.has(event.keycode)
	return false
	
func attempt_mix(event):
	if not _is_processable(event):
		return
	if event.is_action_pressed(_get_mix_key()):
		mix_correctly()
	else:
		mix_attempted.emit(false)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
