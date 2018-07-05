extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

const Potion = preload("res://Scenes/Potion.gd")

# Cook time consts
const MIN_TIME = 45
const MAX_TIME = 90
const TIME_INTERVAL = 5

# Cook temp consts
const MIN_TEMP = 100
const MAX_TEMP = 200
const TEMP_INTERVAL = 10

var ingredient1
var ingredient2
var part1
var part2
var cookTemp
var cookTime
var container
var output

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _init():
	randomize()
	# print(global.ingredients)
	var choices = global.prep_ingredients
	
	# Pick ingredients
	ingredient1 = choices[randi() % choices.size()]
	while (ingredient2 == null or ingredient2 == ingredient1):
		ingredient2 = choices[randi() % choices.size()]
	
	# Calculate part ratio
	part1 = randi() % 9 + 1
	part2 = 10 - part1
	
	# Pick cook temp
	var smallMinTemp = MIN_TEMP / TEMP_INTERVAL
	var smallMaxTemp = MAX_TEMP / TEMP_INTERVAL
	var randIntTemp = randi() % (smallMaxTemp - smallMinTemp + 1) + smallMinTemp
	
	cookTemp = randIntTemp * TEMP_INTERVAL
	
	# Pick cook time
	var smallMinTime = MIN_TIME / TIME_INTERVAL
	var smallMaxTime = MAX_TIME / TIME_INTERVAL
	var randIntTime = randi() % (smallMaxTime - smallMinTime + 1) + smallMinTime
	
	cookTime = randIntTime * TIME_INTERVAL
	
	container = "bottle"
	
	output = Potion
	
	# print(ingredient1)
	# print(ingredient2)
	# print(part1)
	# print(part2)
	# print(cookTime)
	# print(cookTemp)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
