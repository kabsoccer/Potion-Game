extends Node2D

var input = {}
var output
var products = {}
var productsLimit = {}
var reagents = {}
var reagentsLimit = {}
var inputStations = []
var time
var sizeIn
var sizeOut
var counter
var timer
var makeTimer

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass

func start():
	counter = time
	print("Starting timer")
	timer = Timer.new()
	timer.set_wait_time(1)
	timer.connect("timeout", self, "on_timer_timeout")
	add_child(timer)
	timer.start()

func on_timer_timeout():
	gather()

func gather():
	
	# Calculate gather limits
	for i in input:
		reagentsLimit[i] = (input[i] * 0.1) * sizeIn
	
	print("Reagent Limits: " + str(reagentsLimit))
	
	var isFull = true
	
	# Are we at the limit? If so, don't gather
	for i in reagents:
		if reagents[i] >= reagentsLimit[i]:
			print(i + " is full")
		else:
			print(i + " is not full")
			isFull = false
	
	if isFull:
		print("Not gathering")
		return

	# Print initial input quantities
	for i in inputStations:
		print("Input Station: " + str(i.products))
	
	# Gathering inputs from inputStations
	# Loop through inputs
	for i in input:
		var totalReagents = reagentsLimit[i]
		if reagents[i] == reagentsLimit[i]:
			break
		# Loop through input stations
		for j in inputStations:
			# Loop through products of input stations
			for k in j.products:
				# Is this products the right type?
				if k == i and j.products[k] != 0:
					# If so, take what we need, or as much as possible
					print("taking " + str(k) + " from " + str(j))
					if j.products[k] <= totalReagents - reagents[i]:
						reagents[i] = j.products[k]
						j.products[k] = 0
					else:
						j.products[k] -= totalReagents - reagents[i]
						reagents[i] += totalReagents - reagents[i]
	
	# Print final input quantities
	for i in inputStations:
		print("Input Station: " + str(i.products))
	
	# Print the reagents in the cauldron
	print("Reagents: " + str(reagents))
	
func startMakeTimer():
	counter = time
	print("Starting timer")
	makeTimer = Timer.new()
	makeTimer.set_wait_time(1)
	makeTimer.connect("timeout", self, "on_make_timer_timeout")
	add_child(makeTimer)
	makeTimer.start()
	
func on_make_timer_timeout():
	counter = counter - 1
	print(counter)
	if counter <= 0:
		print("Timer finished")
		makeTimer.stop()
		produce()

func make():
	# Did we get enough for the batch?
	var isEnough = true

	for i in reagents:
		if reagents[i] < input[i] * sizeIn:
			print("Not enough " + i + "!")
			isEnough = false
	
	# If not, exit the function
	if !isEnough:
		for i in inputStations:
			print("Input: " + str(i.products))
		print("Input: " + str(reagents))
		return
	
	startMakeTimer()

func produce():
	products[output] = sizeOut
	for i in reagents:
		reagents[i] = reagents[i] - sizeOut
		
	print("Cauldron: " + str(products))
	print("Cauldron: " + str(reagents))