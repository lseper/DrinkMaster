class_name Heart extends Node2D

@onready var heart_sprite = $Heart
@onready var half_heart_sprite = $HalfHeart
@onready var empty_heart = $EmptyHeart

signal heart_depleted

var is_half_heart := false

var health = 2

func hide_full_hearts():
	heart_sprite.visible = false
	half_heart_sprite.visible = false
	
func show_full_hearts():
	if is_half_heart:
		heart_sprite.visible = false
	else:
		heart_sprite.visible = true
	half_heart_sprite.visible = true
		
func damage():
	health -= 1
	if health <= 0:
		half_heart_sprite.visible = false
		heart_depleted.emit()
	else:
		is_half_heart = true
		heart_sprite.visible = false
		half_heart_sprite.visible = true

# Called when the node enters the scene tree for the first time.
func _ready():
	heart_sprite.visible = true
	half_heart_sprite.visible = false
	empty_heart.visible = true
	half_heart_sprite.scale = heart_sprite.scale
	empty_heart.scale = heart_sprite.scale

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
