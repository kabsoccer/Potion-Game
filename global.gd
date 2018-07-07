extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const IntroRecipe = preload("res://IntroRecipe.gd")
const Storage = preload("res://Scenes/Stations/Storage.gd")
const PotionBox = preload("res://Scenes/Stations/PotionBox.tscn")
const BottlingTable = preload("res://Scenes/Stations/BottlingTable.tscn")

var ingredients = {
	"mushroom": {
		"prep": ["chopped", "sliced"]
	},
	"clover": {
		"prep": ["boiled", "chopped"]
	},
	"broccoli": {
		"prep": ["boiled", "chopped"]
	},
	"fairy": {
		"prep": ["boiled", "chopped"]
	}
}

var prep_ingredients = []

var recipes = []

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	
	# Initialize prep_ingredients array
	for i in ingredients:
		var preps = ingredients[i]["prep"]
		for j in preps:
			prep_ingredients.append(str(j + " " + i))
	
	# print(prep_ingredients)
	
	# Create a sample recipe
	var recipe = IntroRecipe.new()
	recipes.append(recipe)
	# print(recipes[0].ingredient1)
	# print(recipes[0].ingredient2)
	
	# Put some ingredients in storage
	var storage = Storage.new()
	storage.products["chopped mushroom"] = 39
	storage.products["boiled broccoli"] = 1000
	# print(storage.output)
	
	var cauldron = get_node("/root/Node2D/Cauldron")
	cauldron.inputStations.append(storage)
	cauldron.input = {"chopped mushroom": 4, "boiled broccoli": 6}
	cauldron.reagents = {"chopped mushroom": 0, "boiled broccoli": 0}
	cauldron.output = "potion"
	
	cauldron.start()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
