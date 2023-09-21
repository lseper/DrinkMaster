class_name SplashScreen extends Node2D

@export var start_scene: PackedScene
@export var background: ColorRect

@onready var screen_size = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"))

@onready var character = $character/doggy
@onready var temptation = $Temptation
@onready var software = $Software

@onready var character_start = character.position
@export var character_end : Vector2
@export var character_movement_speed := 0.4

func no_behavior(_delta):
	return

var fade_out_behavior : Callable = no_behavior

var character_movement : Callable = no_behavior

var text_behavior : Callable = no_behavior

var v := 0.0
func fade_in(delta):
	v += delta * character_movement_speed
	temptation.modulate.a = clamp(v, 0.0, 1.0)
# one second delay
	var stagger = clamp(v - 1.0, 0.0, 1.0)
	software.modulate.a = stagger
	if stagger >= 1.0:
		fade_out_behavior = fade_out
	
var t := 0.0
func move_character(delta):
	t = clamp(t + delta * character_movement_speed, 0.0, 1.0)
	var new_pos = character_start.lerp(character_end, t)
	character.position = new_pos
	if t >= 1.0:
		character_movement = no_behavior
		text_behavior = fade_in

var s := 1.0		
func fade_out(delta):
	s = clamp(s - delta * character_movement_speed, -.5, 1.0)
	var delay = clamp(0.5 + s, 0.0, 1.0)
	modulate.a = delay
	character.modulate.a = clamp(s, 0.0, 1.0)
	if delay <= 0.0:
		get_tree().change_scene_to_packed(start_scene)
		
# Called when the node enters the scene tree for the first time.
func _ready():
	temptation.modulate.a = 0.0
	software.modulate.a = 0.0
	background.size = screen_size

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	character_movement.call(delta)
	text_behavior.call(delta)
	fade_out_behavior.call(delta)

func _on_character_character_finished():
	character_movement = move_character
