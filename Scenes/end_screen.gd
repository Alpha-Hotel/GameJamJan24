extends Control

@onready var again_button = $again_button as Button
@onready var quit_button = $quit_button as Button
@onready var level = preload("res://main.tscn") as PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	again_button.button_down.connect(on_again_pressed)
	quit_button.button_down.connect(on_exit_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_again_pressed() -> void:
	self.visible = false
	get_tree().change_scene_to_file("res://main.tscn")

func on_exit_pressed() -> void:
	get_tree().quit()
	
func set_score(points_earned):
	$CanvasLayer/Score.text = "Score: " + str(points_earned)
	
func set_dead_colonies(colonies_lost):
	$CanvasLayer/Score.text = "Score: " + str(colonies_lost)
	
func set_placed_colonies(colonies_placed):
	$CanvasLayer/Score.text = "Score: " + str(colonies_placed)
		
