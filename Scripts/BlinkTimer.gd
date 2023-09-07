class_name BlinkTimer extends Timer

@export var blink_count := 3

var total_blinks = blink_count * 2

var blinks_complete = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timeout():
	blinks_complete += 1
	if blinks_complete >= total_blinks:
		blinks_complete = 0
		self.stop()
