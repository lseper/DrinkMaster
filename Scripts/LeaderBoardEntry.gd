class_name LeaderBoardEntry extends HSplitContainer

@export var username: String
@export var score: float
@export var rank: int

@onready var username_label = $UsernameLabel
@onready var score_label = $ScoreLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	username_label.text = str(rank) + ". " + username
	score_label.text = "$" + str(round(score * 100) / 100.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
