class_name SelfRemovingButton extends TextureButton

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_pressed():
	get_parent().get_child(0).visible = true
	get_parent().get_child(3).visible = false
	get_parent().get_child(4).visible = false
	visible = false
