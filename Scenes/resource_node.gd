extends Area2D

@export var resources : int = 100
var initial_resources : int = resources
@onready var animated_sprite = $AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	animated_sprite.visible =false
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func absorb_resource():
	print("here")
	$rescource_collider.queue_free()
	animated_sprite.visible =true
	animated_sprite.play()
	
