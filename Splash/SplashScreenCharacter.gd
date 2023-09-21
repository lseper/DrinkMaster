class_name SplashScreenCharacter extends Node2D

@onready var screen_dim = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"))

@onready var animation_tree = $AnimationTree 
@onready var bg_primary = $BackgroundPrimary
@onready var bg_secondary = $BackgroundSecondary
@onready var gameboy = $Gameboy
@onready var stagger_timer = $Timer
@onready var doggy = $doggy

@export var lightning_animation : String
@export var beginning_animation : String
@export var end_animation : String

@export var primary_bg_color : Color
@export var secondary_bg_color: Color

signal character_finished

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_tree.active = false
	doggy.visible = false
	gameboy.play()
	bg_primary.color = primary_bg_color
	bg_secondary.color = secondary_bg_color

func begin_lightning_strike():
	bg_primary.visible = false

func end_lightning_strike():
	bg_primary.visible = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_animation_tree_animation_finished(anim_name):
	if anim_name == beginning_animation:
		begin_lightning_strike()
	if anim_name == lightning_animation:
		end_lightning_strike()
	if anim_name == end_animation:
		character_finished.emit()


func _on_gameboy_animation_finished():
	stagger_timer.start()

var doggy_modulate = 0.0
func _on_timer_timeout():
	doggy.visible = true
	doggy_modulate += 0.25
	doggy.modulate.a = doggy_modulate
	if doggy_modulate >= 1.0:
		stagger_timer.stop()
		animation_tree.active = true
