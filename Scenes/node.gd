extends Node

const mycelia_node = preload("res://Scenes/mycelia_node.tscn")
@export var mycelia_nodes:Array[PackedScene]

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

var closest_node_1
var closest_node_2
var line
## this function finds the two closest nodes, and passes the positions to 
##the two variables defined above to connect lines to.
func find_closest_nodes():
	pass
	
func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton and not event.is_action_released("click"):
		##print("Mouse Click/Unclick at: ", event.position)
		add_mycelia_node(event.position)
		add_connecting_lines(event.position, closest_node_1, closest_node_2)
		
	elif event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.position)
		pass

   # Print the size of the viewport.
	#print("Viewport Resolution is: ", get_viewport().get_visible_rect().size)

func add_mycelia_node(pos):
	var node = mycelia_node.instantiate()

	add_child(node)
	print(node)
	
	node.position = pos
	
func add_connecting_lines(placed_pos, pos_2, pos_3):
	pass
	
