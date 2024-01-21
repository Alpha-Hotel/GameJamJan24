extends Area2D

@export var resources : int = 100
var initial_resources : int = resources

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rescale_resource()
	# Destroy node if resources reach 0.
	if resources <= 0:
		queue_free()
	
func consume_resources(consumption_amount : int) -> int:
		var consumed_resources = 0
		if resources < consumption_amount:
			consumed_resources = resources
			resources = 0
		else:
			consumed_resources = consumption_amount
			resources -= consumption_amount
		return consumed_resources

func rescale_resource():
	#rescale resource based on percentage of initial resources that are left.
	var scale_factor : float = float(resources) / float(initial_resources)
	self.scale = Vector2(scale_factor, scale_factor)
		
