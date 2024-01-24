extends Node

const mycelia_node = preload("res://Scenes/mycelia_node.tscn")
const danger_node = preload("res://Scenes/danger_node.tscn")
const resource_node = preload("res://Scenes/resource_node.tscn")
const connector = preload("res://Scenes/connector.tscn")
const player_hint_danger_node = preload("res://Scenes/player_hint_danger_node.tscn")
const player_hint_resource_node = preload("res://Scenes/player_hint_resource_node.tscn")
const end_screen = preload("res://Scenes/end_screen.tscn")
# Load the custom images for the mouse cursor.
var node_image = load("res://Frames/node.png")
var cursor_x = load("res://Frames/No_node.png")

func _ready():
	$HUD/Counter_number.text = "10"
	Input.set_custom_mouse_cursor(node_image, 0, Vector2(15,15))
	spawn_resource_nodes(30)
	spawn_danger_nodes(30)
	
var rng1 = RandomNumberGenerator.new()
var rng2 = RandomNumberGenerator.new()

func _process(_delta):
	
	if int($HUD/Counter_number.text) == 0:
		var score = int($HUD/Score.text)
		$Control.set_score(score)
		await get_tree().create_timer(1.5).timeout
		$Control.visible = true
		$Control/CanvasLayer.visible = true
		
	#update_node_signal(delta)
	
func _input(event):
	
	if event is InputEventMouseButton and not event.is_action_released("click"):
		# This runs if the mouse is clicked 
		if check_node_collision(event.position)[1].is_empty() and int($HUD/Counter_number.text)>0:
			# Checks collision at the mouse posiiton
			
			var node = add_mycelia_node(event.position)
			select_play_audio()
			$HUD/Counter_number.text = str(int($HUD/Counter_number.text)-1)
			var collisions = expanding_collision() #do something with this
			node.set_connection_list( add_connections(node, custom_collision(20, event.position )[1]))
			var score = node.connection_list.size() * collisions[2].size()
			node.set_score(score)
			increase_score(score)
			
			if not collisions[0].is_empty():
				show_player_hint(collisions)
				reduce_score(node.kill_node())
				chain_death(custom_collision(20, event.position ))
			if not collisions[2].is_empty():
				remove_resource_nodes(collisions)
			var vision_collision = custom_collision(10, event.position)
			if not vision_collision[2].is_empty():
					show_player_hint(vision_collision)
		else:
			if int($HUD/Counter_number.text) > 0:
				pass
		
	elif event is InputEventMouseMotion:
		if not check_node_collision(event.position)[1].is_empty() or custom_collision(20, event.position)[1].is_empty():
			Input.set_custom_mouse_cursor(cursor_x, 0, Vector2(7,7))
		else:
			Input.set_custom_mouse_cursor(node_image, 0, Vector2(15,15))

func add_mycelia_node(pos):
	# This function adds a mycelia node at a given position (pos)
	var node = mycelia_node.instantiate()
	node.position = pos
	add_child(node)
	node.add_to_group("mycelia_nodes")
	return node

func add_danger_node(pos_danger):
	# This function adds a danger node at a given position (pos)
	var node_danger = danger_node.instantiate()
	add_child(node_danger)
	node_danger.position = pos_danger
	node_danger.add_to_group("mycelia_nodes")

func check_node_collision(pos):
	
	#This function uses the Collider node to detect collisions at a given position pos
	$Collider.position = pos
	# Normally collider updates at the physics update step. This forces it to update
	# prior to collision check. 
	$Collider.force_shapecast_update()
	return sort_collisions($Collider.collision_result)

func expanding_collision():	
	# Grows the collider to the size of particle effect, checks for adjacent nodes
	# Returns nodes that were collided with
	$Collider.scale =Vector2(5,5)
	$Collider.force_shapecast_update() 
	$Collider.scale =Vector2(1,1)
	return sort_collisions($Collider.collision_result)

func add_connections(node, pos_list):
	# This function adds a connection line with nodes at two given positions (pos1, pos2)
	var connections_list = []
	for pos2 in pos_list:
		if not pos2["collider"] == node and not pos2["collider"].dying:
			var conn = connector.instantiate()
			add_child(conn)
			var conn_transform = conn.get_global_transform_with_canvas().affine_inverse()
			conn.set_point_position(0, node.position * conn_transform)
			conn.set_point_position(1, pos2.point * conn_transform)
			conn.add_to_group("connectors")
			connections_list.append(conn)
			pos2["collider"].append_connection(conn)
		
	return connections_list

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

func get_attributes_of_all():
	
	for i in get_tree().get_nodes_in_group("mycelia_nodes"):
		print (i)
	
func spawn_resource_nodes(num_spawn):
	for i in num_spawn:
		var randx = rng1.randf_range(0.0, 1152.0)
		var randy = rng2.randf_range(0.0, 648.0)
		var node_copy = resource_node.instantiate()
		add_child(node_copy)
		node_copy.position.x = randx
		node_copy.position.y = randy
		
func spawn_danger_nodes(num_spawn_danger):
	
	for i in num_spawn_danger:
		
		var randx = rng1.randf_range(0.0, 1152.0)
		var randy = rng2.randf_range(0.0, 648.0)
		var node_copy = danger_node.instantiate()
		add_child(node_copy)
		node_copy.position.x = randx
		node_copy.position.y = randy

func chain_death(collision_list):
	for mycelia in collision_list[1]:
		if not mycelia["collider"].dying:
			reduce_score(mycelia["collider"].kill_node())
		
func reduce_score(num:int):
	print("reducing score by ", num)
	$HUD/Score.text = str(int($HUD/Score.text)-num)
	
func increase_score(num:int):
	print("increase score by ", num)
	$HUD/Score.text = str(int($HUD/Score.text)+num)
		
func remove_resource_nodes(collision_list):
	for resource_node_x in collision_list[2]:
		resource_node_x["collider"].queue_free()
		$HUD/Counter_number.text = str(int($HUD/Counter_number.text)+2)

func custom_collision(radius, pos):
	$Collider.position = pos
	$Collider.scale = Vector2(radius, radius)
	$Collider.force_shapecast_update() 
	$Collider.scale = Vector2(1,1)
	return sort_collisions($Collider.collision_result)

func select_play_audio():
	var num_select = randi_range(1, 5)
	if num_select == 1:
		$AudioStreamPlayer.play()
	elif num_select == 2:
		$AudioStreamPlayer2.play()
	elif num_select == 3:
		$AudioStreamPlayer3.play()
	elif num_select == 4:
		$AudioStreamPlayer4.play()
	elif num_select == 5:
		$AudioStreamPlayer5.play()

func show_player_hint(collision_list):
	##check and send particles to danger node
	
	if not collision_list[0].is_empty():
		for danger_node_x in collision_list[0]:
			danger_node_x["collider"].play_particles()
		
	##check and send particles to resource node
	if not collision_list[2].is_empty():
		for resource_node_x in collision_list[2]:
			#instantiate kids
			var resource_node_hint = player_hint_resource_node.instantiate()
			resource_node_hint.position = resource_node_x["point"]
			add_child(resource_node_hint)
		pass
	
func reset_scene():
	
	for mycelia in get_tree().get_nodes_in_group("mycelia_nodes"):
		mycelia.queue_free()
	for danger in get_tree().get_nodes_in_group("danger"):
		danger.queue_free()
	for connector_x in get_tree().get_nodes_in_group("connector"):
		connector_x.queue_free()
	
	spawn_resource_nodes(30)
	spawn_danger_nodes(30)
	$HUD/Counter_number.text = "10"

func _on_control_reset():
	reset_scene() # Replace with function body.



