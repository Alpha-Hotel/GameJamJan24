extends Node

const mycelia_node = preload("res://Scenes/mycelia_node.tscn")
const resource_node = preload("res://Scenes/resource_node.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	$HUD/Counter_number.text = "5"
	spawn_resource_nodes(10)
	get_attributes_of_all()
	
var rng1 = RandomNumberGenerator.new()
var rng2 = RandomNumberGenerator.new()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#update_node_signal(delta)
	pass


var closest_node_1
var closest_node_2
var line
## this function finds the two closest nodes, and passes the positions to 
##the two variables defined above to connect lines to.
func find_closest_nodes():
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
			expanding_collision() #do something with this
		else:
			if int($HUD/Counter_number.text) > 0:
				print("collision ", $Collider.scale)
		add_connecting_lines(event.position, closest_node_1, closest_node_2)
		
	elif event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.position)
		pass

func add_mycelia_node(pos):
	# This function adds a mycelia node at a given position (pos)
	var node = mycelia_node.instantiate()
	add_child(node)
	node.position = pos
	node.add_to_group("mycelia_nodes")
	#ready_node_signal(pos)
	


func check_node_collision(pos):
	#This function uses the Collider node to detect collisions at a given position pos
	$Collider.position = pos
	# Normally collider updates at the physics update step. This forces it to update
	# prior to collision check. 
	$Collider.force_shapecast_update() 
	return $Collider.is_colliding()

func expanding_collision():	
	$Collider.scale =Vector2(10,10)
	$Collider.force_shapecast_update() 
	print("expanding collision ", $Collider.is_colliding())
	$Collider.scale =Vector2(1,1)
	
	return get_non_player($Collider.collision_result)
	

func get_non_player(list):
	var new_list = []
	for i in list:
		if not i["collider"] in get_tree().get_nodes_in_group("mycelia_nodes"):
			new_list.append(i)
			print("non-mycelia hit")
		else:
			print("mycelia node hit")
		
	return new_list


func add_connecting_lines(placed_pos, pos_2, pos_3):
	pass
	
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
