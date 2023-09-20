class_name ResultsPane extends Node2D

@export var total_time : float

@onready var drinks_total_text = $Totals/Drinks
@onready var tip_total_text = $Totals/Tips
@onready var bonus_total_text = $Totals/Bonus

@onready var grand_total_text = $GrandTotal

var begin := false
var score_submitted := false

@onready var accumulate_order_text = [drinks_total_text, tip_total_text, bonus_total_text]
# [drinks, tips, bonus]
var accumulate_order_totals = [0.0, 0.0, 0.0]

var curr_text_label
var curr_total
var curr_total_accumulater = 0.0
var grand_total = 0.0

# the dollar amount that it counts, per second
var total_money_to_add : float
var count_speed : float
# Nearest cent
const EPSILON = 0.00999

var username := "Zaverose"

signal resume

func reset():
	accumulate_order_totals = [0.0, 0.0, 0.0]
	for text_label in accumulate_order_text:
		text_label.text = "$0.00"
	grand_total = 0.0
	curr_total_accumulater = 0.0
	begin = false

func _accumulate_next() -> bool:
	if accumulate_order_totals.size() > 0:
		curr_total = accumulate_order_totals.pop_front()
		curr_text_label = accumulate_order_text.pop_front()
		curr_total_accumulater = 0.0
		return true
	else:
		return false
		
func submit_score(username: String, score_to_submit: float):
	SilentWolf.Scores.save_score(username, round(score_to_submit * 100) / 100.0)

# Called when the node enters the scene tree for the first time.
func _ready():
	begin = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if begin:
		var money_to_add_this_frame = count_speed * delta
		var actual_money_added = round(clamp(money_to_add_this_frame, money_to_add_this_frame, curr_total) * 100) / 100.0
		curr_total -= actual_money_added
		curr_total_accumulater += actual_money_added
		curr_text_label.text = "$" + str(round(curr_total_accumulater * 100) / 100.0)
		grand_total += actual_money_added
		grand_total_text.text = str(round(grand_total * 100) / 100.0)
		if abs(curr_total) <= EPSILON:
			var result = _accumulate_next()
			begin = result

func _on_game_manager_game_over(drinks_total, tips_total, bonus_total):
	begin = true
	accumulate_order_totals = [drinks_total, tips_total, bonus_total]
	total_money_to_add = accumulate_order_totals.reduce(func(acc, number): return acc + number, 0.0)
	count_speed = total_money_to_add / total_time
	submit_score(username, total_money_to_add)
	_accumulate_next()

func _on_replay_pressed():
	resume.emit()
	reset()
	get_tree().change_scene_to_file("res://Scenes/main.tscn")

func _on_exit_pressed():
	resume.emit()
	reset()
	get_tree().change_scene_to_file("res://Scenes/start_menu.tscn")


func _on_help_panel_set_name(username_to_set):
	username = username_to_set
