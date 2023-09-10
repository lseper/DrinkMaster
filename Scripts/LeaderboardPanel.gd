class_name LeaderboardPanel extends Sprite2D

func close_leaderboard():
	get_parent().process_mode = Node.PROCESS_MODE_INHERIT
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("pause"):
		close_leaderboard()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_button_pressed():
	close_leaderboard()
