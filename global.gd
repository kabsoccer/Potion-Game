extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
const IntroRecipe = preload("res://IntroRecipe.gd")
const Box = preload("res://Scenes/Stations/IngBox.tscn")
const PotionBox = preload("res://Scenes/Stations/PotionBox.tscn")

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
	
	print(prep_ingredients)
	
	# Create a sample recipe
	var recipe = IntroRecipe.new()
	recipes.append(recipe)
	print(recipes[0].ingredient1)
	print(recipes[0].ingredient2)
	
	# Create some boxes to test with
	var inputBox1 = Box.instance()
	inputBox1.position = Vector2(50, 50)
	inputBox1.contentType = "chopped mushroom"
	inputBox1.amount = 2
	add_child(inputBox1)
	
	var inputBox2 = Box.instance()
	inputBox2.position = Vector2(50, 100)
	inputBox2.contentType = "boiled broccoli"
	inputBox2.amount = 100
	add_child(inputBox2)
	
	var outputBox = PotionBox.instance()
	outputBox.position = Vector2(500, 100)
	add_child(outputBox)
	
	var cauldron = get_node("/root/Node2D/Cauldron")
	cauldron.inputStations.append(inputBox1)
	cauldron.inputStations.append(inputBox2)
	cauldron.outputStations.append(outputBox)
	
	cauldron.make()

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
