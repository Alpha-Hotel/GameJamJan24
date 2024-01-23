extends Node

var child_node

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func child_node_pass(node):
	child_node = node
	
func get_child_node_coords():
	return child_node.get_location()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
