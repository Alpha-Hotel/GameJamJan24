extends Area2D
var played = false
# Called when the node enters the scene tree for the first time.
func _ready():
	$player_hint_danger_node.emitting = false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func play_particles():
	if not played:
		$player_hint_danger_node.emitting = true
		played = true
