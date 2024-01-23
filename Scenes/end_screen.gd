extends Control
signal reset

@onready var again_button = $again_button as Button
@onready var quit_button = $quit_button as Button
@onready var level = preload("res://main_scene.tscn") as PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	again_button.button_down.connect(on_again_pressed)
	quit_button.button_down.connect(on_exit_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func on_again_pressed() -> void:
	reset.emit()
	print("reset signal sent!")
	await get_tree().create_timer(1.5).timeout
	self.visible = false
	
func on_exit_pressed() -> void:
	get_tree().quit()
	
func set_score(points_earned):
	$CanvasLayer/Score.text = "Score: " + str(points_earned)
	
func set_dead_colonies(colonies_lost):
	$CanvasLayer/Score.text = "Score: " + str(colonies_lost)
	
func set_placed_colonies(colonies_placed):
	$CanvasLayer/Score.text = "Score: " + str(colonies_placed)
		
