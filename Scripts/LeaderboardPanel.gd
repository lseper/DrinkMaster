class_name LeaderboardPanel extends Sprite2D

var scores : Array = []

@onready var leaderboard_root = $LeaderboardScroll/LeaderboardVbox
@export var leaderboard_entry : PackedScene

func _populate_leaderboard():
	for i in range(0, scores.size()):
		var score = scores[i]
		var score_instance = leaderboard_entry.instantiate()
		score_instance.rank = i + 1
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

func _get_top_leaderboard_players(cutoff: int):
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores(0).sw_get_scores_complete
	var scores_non_unique: Array = sw_result.scores.map(func(score_raw): return {"username": score_raw.player_name, "score" : score_raw.score})
	scores = _filter_unique_player_scores(scores_non_unique, cutoff)

func _filter_unique_player_scores(player_scores: Array, cutoff: int):
	var players = []
	var unique_scores = []
	for score in player_scores:
		if not players.has(score.username):
			players.append(score.username)
			unique_scores.append(score)
		if players.size() >= cutoff:
			return unique_scores
	return unique_scores

func _on_replay_pressed():
	_clear_leaderboard()
	await _get_top_leaderboard_players(100)
	_populate_leaderboard()
