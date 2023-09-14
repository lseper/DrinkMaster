class_name StartMenu extends Sprite2D

@onready var exit_button = $ExitButton
@onready var start_button = $StartButton
@onready var leader_board_button = $LeaderboardButton

func disable():
	exit_button.disabled = true
	start_button.disabled = true
	leader_board_button.disabled = true

func enable():
	exit_button.disabled = false
	start_button.disabled = false
	leader_board_button.disabled = false

# Called when the node enters the scene tree for the first time.
func _ready():
	SilentWolf.configure({
		"api_key": "jaUzQR0o2e4Mm7sP9TS3L1GtCjJc5l5z4q9HTj1D",
		"game_id": "DrinkMaster",
		"log_level": 1
	})


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
