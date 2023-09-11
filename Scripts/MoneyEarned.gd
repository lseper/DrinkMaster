class_name MoneyEarned extends Node2D

@export var drink_cost : float = 2.99
@export var staggered_label : PackedScene
@export var staggered_text : String
@onready var drink_cost_label = $DrinkCostLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	drink_cost_label.text = "+ $" + str(drink_cost)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_tip_delay_timeout():
	var tip_label_instance = staggered_label.instantiate()
	tip_label_instance.text = staggered_text
	add_child(tip_label_instance)
	tip_label_instance.despawning.connect(func(): queue_free())
