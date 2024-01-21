extends Node

const mycelia_node = preload("res://Scenes/mycelia_node.tscn")
const resource_node = preload("res://Scenes/resource_node.tscn")
const connector = preload("res://Scenes/connector.tscn")
# Load the custom images for the mouse cursor.
var node_image = load("res://Frames/node.png")
var cursor_x = load("res://Frames/No_node.png")


func _ready():
	Input.set_custom_mouse_cursor(node_image, 0, Vector2(15,15))
	$HUD/Counter_number.text = "5"
	spawn_resource_nodes(10)
	get_attributes_of_all()
	
var rng1 = RandomNumberGenerator.new()
var rng2 = RandomNumberGenerator.new()


func _process(delta):
	#update_node_signal(delta)
	pass



func _input(event):
	
	if event is InputEventMouseButton and not event.is_action_released("click"):
		# This runs if the mouse is clicked 
		print("Mouse Click/Unclick at: ", )
		if not check_node_collision(event.position) and int($HUD/Counter_number.text)>0:
			# Checks collision at the mouse posiiton
			print("no collision")
			add_mycelia_node(event.position)
			$HUD/Counter_number.text = str(int($HUD/Counter_number.text)-1)
			var collisions = expanding_collision() #do something with this
			add_connections(event.position, collisions[1])
		else:
			if int($HUD/Counter_number.text) > 0:
				print("collision ", $Collider.scale)

		
	elif event is InputEventMouseMotion:
		if check_node_collision(event.position) or expanding_collision()[1].is_empty():
			Input.set_custom_mouse_cursor(cursor_x, 0, Vector2(7,7))
		else:
			Input.set_custom_mouse_cursor(node_image, 0, Vector2(15,15))


func add_mycelia_node(pos):
	# This function adds a mycelia node at a given position (pos)
	var node = mycelia_node.instantiate()
	add_child(node)
	node.position = pos
	node.add_to_group("mycelia_nodes")



func check_node_collision(pos):
	#This function uses the Collider node to detect collisions at a given position pos
	$Collider.position = pos
	# Normally collider updates at the physics update step. This forces it to update
	# prior to collision check. 
	$Collider.force_shapecast_update() 
	return $Collider.is_colliding()

func expanding_collision():	
	# Grows the collider to the size of particle effect, checks for adjacent nodes
	# Returns nodes that were collided with
	$Collider.scale =Vector2(10,10)
	$Collider.force_shapecast_update() 
	print("expanding collision ", $Collider.is_colliding())
	$Collider.scale =Vector2(1,1)
	return sort_collisions($Collider.collision_result)
	
func add_connections(pos1, pos_list):
	# This function adds a connection line with nodes at two given positions (pos1, pos2)
	for pos2 in pos_list:
		var conn = connector.instantiate()
		add_child(conn)
		var conn_transform = conn.get_global_transform_with_canvas().affine_inverse()
		conn.set_point_position(0, pos1 * conn_transform)
		conn.set_point_position(1, pos2.point * conn_transform)
		conn.add_to_group("connectors")

func sort_collisions(list):
	# returns a list with two lists. The zeroth list is for non-mycelia nodes
	# the list with index 1 is all mycelia group nodes.
	var new_list = [[],[]]
	for i in list:
		if not i["collider"] in get_tree().get_nodes_in_group("mycelia_nodes"):
			new_list[0].append(i)
		else:
			new_list[1].append(i)
	return new_list



func get_attributes_of_all():
	
	for i in get_tree().get_nodes_in_group("resource"):
		print (get_tree().get_nodes_in_group("resource"))
	
func spawn_resource_nodes(num_spawn):
	
	for i in num_spawn:
		
		var randx = rng1.randf_range(0.0, 1152.0)
		var randy = rng2.randf_range(0.0, 648.0)
		var node_copy = resource_node.instantiate()
		add_child(node_copy)
		node_copy.position.x = randx
		node_copy.position.y = randy
