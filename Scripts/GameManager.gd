class_name GameManager extends Node2D

@onready var coin_counter_label = $UI/Label
@onready var drink_order_timer = $DrinkOrderTimerBar
@onready var actual_drink_order_timer = $DrinkOrderTimerBar/DrinkOrderTimer
@onready var health_bar = $HealthBar

@onready var background = $Background

@onready var pause_panel = $PausePanel

@export var rum_ingredient : PackedScene
@export var wine_ingredient : PackedScene
@export var soda_ingredient : PackedScene
@export var vodka_ingredient : PackedScene
@export var ice_ingredient : PackedScene

@export var success_icon : PackedScene
@export var unsuccess_icon : PackedScene

@onready var ingredients = [rum_ingredient, wine_ingredient, soda_ingredient, vodka_ingredient, ice_ingredient]

var recipe_start_position = Vector2(430, 55)
const INGREDIENT_WIDTH = 70

const tip_percentage = 0.2

var recipe : Array = []
var recipe_complexity : int

var earnings : float = 0.0

# each second that passes, the timer is decreased (upon successful mix) by 0.02 more
const DIFFICULTY_INCREASE_PER_SECOND := 0.02

var start_time : int

func get_difficulty_factor():
	var difficulty_factor = ((Time.get_ticks_msec() - start_time) / 1000.0) * DIFFICULTY_INCREASE_PER_SECOND
	print(difficulty_factor)
	return difficulty_factor

func restart_drink_timer_with_increased_difficulty():
	drink_order_timer.set_new_drink_order_time(actual_drink_order_timer.wait_time - get_difficulty_factor())
	
func restart_drink_timer_with_decreased_difficulty():
	drink_order_timer.set_new_drink_order_time(actual_drink_order_timer.wait_time + (2.0 * get_difficulty_factor()))

func _on_mix_attempted(successful: bool):
	if successful:
		recipe.pop_front()
	else:
		health_bar.damage()

# Called when the node enters the scene tree for the first time.
func _ready():
	background.play("default")
	coin_counter_label.text = "$" + str(round(earnings * 100) / 100.0)
	pause_panel.hide()
	order_new_drink()
	start_time = Time.get_ticks_msec()

func earn_money():
	var tip_ratio = tip_percentage * (actual_drink_order_timer.time_left / actual_drink_order_timer.wait_time)
	var payout = (recipe_complexity * 0.5)
	payout *= (1.0 + tip_ratio)
	earnings += payout
	coin_counter_label.text = "$" + str(round(earnings * 100) / 100.0)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if recipe.size() <= 0:
		earn_money()
		order_new_drink()
		restart_drink_timer_with_increased_difficulty()

func pause_game():
	get_tree().paused = true
	pause_panel.show()

func _input(event):
	if recipe.size() <= 0:
		return
	if event.is_action_pressed("pause") and not get_tree().paused:
		pause_game()
	elif event is InputEventKey and event.is_pressed():
		recipe[0].attempt_mix(event)

func order_new_drink():
	recipe = []
	var recipe_length = randi_range(2, 5)
	recipe_complexity = recipe_length
	for i in range(recipe_length):
		var ingredient_instance = ingredients[randi_range(0, ingredients.size() - 1)].instantiate()
		ingredient_instance.position = recipe_start_position
		ingredient_instance.position.x = recipe_start_position.x - (i * INGREDIENT_WIDTH)
		ingredient_instance.mix_attempted.connect(_on_mix_attempted)
		self.add_child(ingredient_instance)
		recipe.append(ingredient_instance)

func clear_drink():
	for ingredient in recipe:
		ingredient.queue_free()

func _on_drink_order_timer_timeout():
	clear_drink()
	order_new_drink()
	restart_drink_timer_with_decreased_difficulty()

func _on_health_bar_health_depleted():
	print("GAME OVER :(")
