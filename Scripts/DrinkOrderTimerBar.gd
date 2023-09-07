class_name DrinkOrderTimer extends TextureProgressBar

@onready var timer = $DrinkOrderTimer
@export var initial_drink_order_time := 10.0

@onready var drink_order_time = initial_drink_order_time

func set_new_drink_order_time(new_time: float):
	drink_order_time = new_time
	timer.wait_time = new_time
	value = 100
	timer.stop()
	timer.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.wait_time = drink_order_time * (value / 100.0)
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	value = (timer.time_left / drink_order_time) * 100


func _on_health_bar_health_depleted():
	timer.stop()
