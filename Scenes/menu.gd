class_name main_menu
extends Control
signal kill_me

@onready var start_button = $VBoxContainer/start_button as Button
@onready var quit_button = $VBoxContainer/quit_button as Button
@onready var level_select = preload("res://main_scene.tscn") as PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	start_button.button_down.connect(on_start_pressed)
	quit_button.button_down.connect(on_exit_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_start_pressed() -> void:
	kill_me.emit()

func on_exit_pressed() -> void:
	get_tree().quit()


