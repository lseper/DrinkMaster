class_name ExitBehaviour extends Node

@export var root : Node2D

@export var initial_velocity := Vector2(0, 25)
@export var acceleration := Vector2(0, -100)
@export var exit_max_speed := Vector2(0, 100)

@export var visibility_decay_rate := 0.4

@onready var queue_free_timer = $QueueFreeTimer

var velocity = Vector2(0, 0)
var begin_processing : bool

func exit():
	velocity = initial_velocity
	queue_free_timer.start()
	begin_processing = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	root.position += (velocity * delta)
	if begin_processing:
		if root is Sprite2D or root is AnimatedSprite2D:
			root.modulate.a = clamp(root.modulate.a - visibility_decay_rate * delta, 0, 1.0)
		velocity = clamp(velocity + (acceleration * delta), -1 * Vector2(abs(exit_max_speed.x), abs(exit_max_speed.y)), exit_max_speed)


func _on_queue_free_timer_timeout():
	root.queue_free()
