extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var cauldron = load("res://Scenes/Cauldron.tscn")

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_ColorRect_pressed():
	var node = get_parent().get_parent().get_parent()
	var cauldronNode = cauldron.instance()
	cauldronNode.position = node.position
	
	node.get_parent().add_child(cauldronNode)
	
	for child in node.get_children():
		child.queue_free()
	node.queue_free()
	pass # replace with function body
