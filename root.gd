extends Node
const main = preload("res://main_scene.tscn")
const menu = preload("res://Scenes/menu.tscn")
const tutorial = preload("res://Scenes/Tutorial.tscn")
var time_in_seconds = .01
# Called when the node enters the scene tree for the first time.
func _ready():
	add_menu()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_menu():
	#Adds main menu to the scene tree, connects kill signal
	var menu_ = menu.instantiate()
	add_child(menu_)
	menu_.add_to_group("menu")
	menu_.kill_me.connect(kill_menu)
	menu_.tutorial.connect(add_tutorial)

func add_main():
	# Adds the main scene to the tree and connects the reset signal
	var main_ = main.instantiate()
	main_.add_to_group("main")
	add_child(main_)
	main_.get_node("Control").reset.connect(_on_restart)
	return main_

func add_tutorial():
	for i in get_tree().get_nodes_in_group("menu"):
		i.queue_free()
	var t = tutorial.instantiate()
	add_child(t)
	t.add_to_group("t")
	t.kill_me.connect(kill_t)
	print(get_tree().get_signal_connection_list("kill_t"))

func kill_t():
	
	for i in get_tree().get_nodes_in_group("t"):
		i.queue_free()
	await get_tree().create_timer(time_in_seconds).timeout
	add_menu()

func kill_menu():
	# frees the menu to ensure no weird scene hierarchy happens
	for i in get_tree().get_nodes_in_group("menu"):
		i.queue_free()
	await get_tree().create_timer(time_in_seconds).timeout
	add_main()

func _on_restart():
	# frees all loaded "main scenes" and replaces itself with a new main scene
	for i in get_tree().get_nodes_in_group("main"):
		i.queue_free()
	
	await get_tree().create_timer(time_in_seconds).timeout #necessary so that godot doesn't break
	add_main()
