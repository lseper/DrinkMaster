class_name RisingLabel extends Label

@export var rise_velocity := Vector2(0, -25)
@export var fade_amount := 1.0

@onready var despawn_timer = $DespawnTimer

signal despawning

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += rise_velocity * delta
	modulate.a -= clamp(fade_amount * delta, 0.0, 1.0)

func _on_despawn_timer_timeout():
	despawning.emit()
	queue_free()
