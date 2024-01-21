extends Control

@onready var level_select_6 = $start_button6 as Button

@onready var level_selected_test_env = preload("res://main.tscn") as PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	level_select_6.button_down.connect(on_lvl6_pressed)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_lvl6_pressed() -> void:
	get_tree().change_scene_to_packed(level_selected_test_env)



