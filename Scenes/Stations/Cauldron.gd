extends 'Station.gd'

var temp

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _init():
	maxReagents = 100
	maxProducts = 10
	time = 10
	batchSize = 10

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
	
# Make the output
# Assumes station has exactly amount needed for one batch