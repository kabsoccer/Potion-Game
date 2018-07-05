extends 'Station.gd'

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const Station = preload("res://Scenes/Stations/Station.gd")

var input = {"chopped mushroom": 4, "boiled broccoli": 6}
var output
var amount = {}
var inputStations = []
var outputStations = []
var temp
var time
var size

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func make():
	# Print initial input quantities
	for i in inputStations:
		print(i.contentType + str(i.amount))
	
	# Gathering inputs from inputStations
	for i in input:
		amount[i] = 0
		for j in inputStations:
			if j.contentType == i:
				print("taking " + str(j.contentType) + " from " + str(j))
				if j.amount <= input[i] - amount[i]:
					amount[i] = j.amount
					j.amount = 0
				else:
					j.amount -= input[i] - amount[i]
					amount[i] += input[i] - amount[i]

	# Did we get enough for the batch?
	for i in amount:
		if amount[i] < input[i]:
			print("Not enough " + i + "!")
			print(amount)
			return
	
	# Print final input quantities
	for i in inputStations:
		print(i.contentType + str(i.amount))
	
	# Print the amount of inputs in the cauldron
	print(amount)