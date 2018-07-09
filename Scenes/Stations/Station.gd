extends Node2D

var input = {}
var output = {}
var products = {}
var maxProducts
var reagents = {}
var maxReagents
var reagentsLimits = {}
var inputStations = []
var isBatch
var batchSize
var time
var counter
var timer
var runTimer

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func start():
	counter = time
	print("Initializing")
	timer = Timer.new()
	timer.set_wait_time(1)
	timer.connect("timeout", self, "on_timer_timeout")
	add_child(timer)
	timer.start()
	runTimer = Timer.new()

func on_timer_timeout():
	gather()
	runCheck()

func gather():
	
	# Calculate gather limits
	for i in input:
		reagentsLimits[i] = input[i] * maxReagents / 10
	
	# print("Reagent Limits: " + str(reagentsLimits))
	
	var isFull = true
	
	# If the station is a BATCH process, don't gather during run
	if runTimer.is_stopped() and isBatch == true:
		pass
	else:
		# print("busy running")
		return
	
	# Are we at the limit? If so, don't gather
	for i in reagents:
		if reagents[i] >= reagentsLimits[i]:
			# print(i + " is full")
			pass
		else:
			# print(i + " is not full")
			isFull = false
	
	if isFull:
		# print("Not gathering")
		return
	
	# Print initial input quantities
	# for i in inputStations:
		# print("Input Station: " + str(i.products))
	
	# Gathering inputs from inputStations
	# Loop through inputs
	for i in input:
		var totalReagents = reagentsLimits[i]
		if reagents[i] == reagentsLimits[i]:
			break
		# Loop through input stations
		for j in inputStations:
			# Loop through products of input stations
			for k in j.products:
				# Is this products the right type?
				if k == i and j.products[k] != 0:
					# If so, take what we need, or as much as possible
					# print("taking " + str(k) + " from " + str(j))
					if j.products[k] <= totalReagents - reagents[i]:
						reagents[i] = j.products[k]
						j.products[k] = 0
					else:
						j.products[k] -= totalReagents - reagents[i]
						reagents[i] += totalReagents - reagents[i]
	
	# Print final input quantities
	# for i in inputStations:
		# print("Input Station: " + str(i.products))
	
	# Print the reagents in the cauldron
	# print("Reagents: " + str(reagents))

func runCheck():
	# Did we get enough for the batch?
	var isEnough = true
	
	# Is the station already running?
	if runTimer.is_stopped():
		pass
	else:
		# print("busy running")
		return
	
	for i in reagents:
		if reagents[i] < input[i] * batchSize:
			print("Not enough " + i + "!")
			isEnough = false
	
	# If not, exit the function
	if !isEnough:
		for i in inputStations:
			print("Input: " + str(i.products))
		print("Reagents: " + str(reagents))
		return
	
	# Is there room for a new batch?
	var totalProducts = 0
	
	for i in products:
		totalProducts += products[i]
	
	var totalOutput = 0
	
	for i in output:
		totalOutput += output[i]
	
	if totalProducts <= maxProducts - totalOutput:
		if runTimer.is_stopped():
			print("runCheck successful!")
			for i in reagents:
				reagents[i] -= input[i] * batchSize
			startRunTimer()
	else:
		print("busy or no room for products")

func startRunTimer():
	counter = time
	print("Starting timer")
	runTimer.set_wait_time(1)
	runTimer.connect("timeout", self, "on_run_timer_timeout")
	add_child(runTimer)
	runTimer.start()

func on_run_timer_timeout():
	counter = counter - 1
	print(counter)
	if counter <= 0:
		print("Timer finished")
		runTimer.stop()
		run()

func run():
	print("run")
	for i in output:
		products[i] += output[i]
	print(products)
	clear()
	
func clear():
	for i in output:
		products[i] -= products[i]
	print("cleared!")