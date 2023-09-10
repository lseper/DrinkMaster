class_name LeaderBoardButton extends TextureButton

@export var leaderboard_panel : LeaderboardPanel
@export var start_menu : StartMenu

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	leaderboard_panel.process_mode = Node.PROCESS_MODE_ALWAYS
	leaderboard_panel.visible = true
	get_parent().process_mode = Node.PROCESS_MODE_DISABLED
