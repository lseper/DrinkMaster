class_name LeaderboardPanel extends Sprite2D

var scores : Array = []

@onready var leaderboard_root = $LeaderboardScroll/LeaderboardVbox
@export var leaderboard_entry : PackedScene

func _populate_leaderboard():
	for score in scores:
		var score_instance = leaderboard_entry.instantiate()
		score_instance.username = score.username
		score_instance.score = score.score
		leaderboard_root.add_child(score_instance)
		
func _clear_leaderboard():
	for entry in leaderboard_root.get_children():
		entry.queue_free()

func close_leaderboard():
	get_parent().process_mode = Node.PROCESS_MODE_INHERIT
	visible = false
	process_mode = Node.PROCESS_MODE_DISABLED

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input(event):
	if event.is_action_pressed("pause"):
		close_leaderboard()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_back_button_pressed():
	close_leaderboard()

func _on_replay_pressed():
	_clear_leaderboard()
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores().sw_get_scores_complete
	scores = sw_result.scores.map(func(score_raw): return {"username": score_raw.player_name, "score" : score_raw.score})
	print(scores)
	_populate_leaderboard()
