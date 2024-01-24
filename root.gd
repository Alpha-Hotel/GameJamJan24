extends Node
const main = preload("res://main_scene.tscn")
const menu = preload("res://Scenes/menu.tscn")
var time_in_seconds = .01
# Called when the node enters the scene tree for the first time.
func _ready():
	add_menu()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func add_menu():
	var menu_ = menu.instantiate()
	add_child(menu_)
	menu_.add_to_group("menu")
	menu_.kill_me.connect(kill_menu)

func add_main():
	# This function adds a mycelia node at a given position (pos)
	var main_ = main.instantiate()
	main_.add_to_group("main")
	add_child(main_)
	main_.get_node("Control").reset.connect(_on_restart)
	print(get_tree().get_signal_connection_list("reset"))
	return main_

func kill_menu():
	for i in get_tree().get_nodes_in_group("menu"):
		i.queue_free()
	add_main()
	print("kill menu")

func _on_restart():
	print("here")
	for i in get_tree().get_nodes_in_group("main"):
		i.queue_free()
	
	await get_tree().create_timer(time_in_seconds).timeout #necessary so that godot doesn't break
	add_main()
