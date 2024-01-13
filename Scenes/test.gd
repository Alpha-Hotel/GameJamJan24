extends Node

const mycelia_node = preload("res://Scenes/mycelia_node.tscn")
@export var mycelia_nodes:Array[PackedScene]

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton and not event.is_action_released("click"):
		print("Mouse Click/Unclick at: ", event.position)
		add_mycelia_node(event.position)
		
	elif event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.position)
		pass

   # Print the size of the viewport.
	#print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)

func add_mycelia_node(pos):
	var node = mycelia_node.instantiate()

	add_child(node)
	node.position = pos
	
