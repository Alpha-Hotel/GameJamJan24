extends Node2D
var node_image = load("res://Frames/node.png")
var cursor_x = load("res://Frames/No_node.png")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
func _input(event):
	if event is InputEventMouseMotion:
		if not check_node_collision(event.position)[1].is_empty() or custom_collision(20, event.position)[1].is_empty():
			Input.set_custom_mouse_cursor(cursor_x, 0, Vector2(7,7))
		else:
			Input.set_custom_mouse_cursor(node_image, 0, Vector2(15,15))

func check_node_collision(pos):
	
	#This function uses the Collider node to detect collisions at a given position pos
	$Collider.position = pos
	# Normally collider updates at the physics update step. This forces it to update
	# prior to collision check. 
	$Collider.force_shapecast_update()
	return sort_collisions($Collider.collision_result)

func custom_collision(radius, pos):
	$Collider.position = pos
	$Collider.scale = Vector2(radius, radius)
	$Collider.force_shapecast_update() 
	$Collider.scale = Vector2(1,1)
	return sort_collisions($Collider.collision_result)
	
func sort_collisions(list):
	# returns a list with two lists. The zeroth list is for non-mycelia nodes
	# the list with index 1 is all mycelia group nodes.
	var new_list = [[], [], []]
	for i in list:
		if i["collider"] in get_tree().get_nodes_in_group("danger"):
			#collider is danger node
			new_list[0].append(i)
		elif i["collider"] in get_tree().get_nodes_in_group("mycelia_nodes"):
			#collider is mycelia node
			new_list[1].append(i)
		else: #resource nodes
			new_list[2].append(i)
	return new_list
