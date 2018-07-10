extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const Worker = preload("res://Scenes/Worker.tscn")

var gatherQueue = []
var workerList = []

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _process(delta):
	if gatherQueue.size() == 0:
		return
		
	var worker = null
	for i in workerList:
		if !i.isBusy:
			worker = i
			break
	
	if worker == null:
		print("No free workers")
		return
		
	var request = gatherQueue.pop_front()
	request["station"].assign(worker, "gather", request["param"])
	worker.isBusy = true
	
	print("Gather queue: " + str(gatherQueue))

func createWorker():
	var worker = Worker.instance()
	get_node("/root/Node2D/Workers").add_child(worker)
	workerList.append(worker)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func askGather(station, param):
	# Check for duplicates
	for i in gatherQueue:
		if i["station"] == station and i["param"] == param:
			return

	gatherQueue.append({"station": station, "param": param})
	print("Gather queue: " + str(gatherQueue))

func send():
	pass