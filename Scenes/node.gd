extends Node

const mycelia_node = preload("res://Scenes/mycelia_node.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print($Collider.is_colliding)
	pass
	
func _input(event):
	
	if event is InputEventMouseButton and not event.is_action_released("click"):
		# This runs if the mouse is clicked 
		print("Mouse Click/Unclick at: ", )
		if not check_collision(event.position):
			# Checks collision at the mouse posiiton
			print("no collision")
			add_mycelia_node(event.position)
		else:
			print("collision")
		
	elif event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.position)
		pass



func add_mycelia_node(pos):
	# This function adds a mycelia node at a given position (pos)
	var node = mycelia_node.instantiate()
	add_child(node)
	node.position = pos

func check_collision(pos):
	#This function uses the Collider node to detect collisions at a given position pos
	$Collider.position = pos
	# Normally collider updates at the physics update step. This forces it to update
	# prior to collision check. 
	$Collider.force_shapecast_update() 
	return $Collider.is_colliding()
