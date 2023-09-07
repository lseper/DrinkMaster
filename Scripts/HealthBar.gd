class_name HealthBar extends Node2D

@export var HeartIcon : PackedScene
@export var starting_health := 3

@export var space_between_hearts := 32

@onready var blink_timer = $BlinkTimer

var health = starting_health * 2

var health_bar_visible := true

var hearts = []

signal health_depleted

func _on_heart_depleted():
	hearts.pop_back()
	
func set_heart_visibility(full: bool):
	for heart in hearts:
		if full:
			heart.show_full_hearts()
		else:
			heart.hide_full_hearts()

func damage():
	blink_timer.start()
	health -= 1
	if hearts.size() > 0:
		hearts[hearts.size() - 1].damage()
	if health == 0:
		health_depleted.emit()

# Called when the node enters the scene tree for the first time.
func _ready():
	health = starting_health * 2
	for i in range(starting_health):
		var heart_instance = HeartIcon.instantiate()
		heart_instance.position.x += space_between_hearts * i
		hearts.append(heart_instance)
		heart_instance.heart_depleted.connect(_on_heart_depleted)
		self.add_child(heart_instance)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_blink_timer_timeout():
	health_bar_visible = not health_bar_visible
	set_heart_visibility(health_bar_visible)


func _on_drink_order_timer_timeout():
	damage()
