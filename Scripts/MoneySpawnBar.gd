class_name LabelSpawner extends Area2D

@export var money_label : PackedScene

@onready var spawn_bounds_collision = $CollisionShape2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _random_spawn_position():
	var min_x = spawn_bounds_collision.position.x + spawn_bounds_collision.shape.b.x
	var max_x = spawn_bounds_collision.position.x + spawn_bounds_collision.shape.a.x
	var y = spawn_bounds_collision.position.y + spawn_bounds_collision.shape.a.y
	return Vector2(randi_range(min_x, max_x), y)

func _on_game_manager_money_earned(base, tip):
	var labels_instance = money_label.instantiate()
	labels_instance.drink_cost = round(base * 100) / 100.0
	labels_instance.staggered_text = "+ $" + str(round(tip * 100) / 100.0)
	labels_instance.position = _random_spawn_position()
	add_child(labels_instance)
