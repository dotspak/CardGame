extends Control
class_name Drafter

# each entry is an array where [0] = rarity, [1] = type
# Rarites:
#	B = basic, R = rare, SR = Super Rare, DR = Divine Rare
# Types:
# 	U = unit, S = spell, O = off-site, ? = random
const layout : Array = [
	["B", "U"], ["B", "U"], ["B", "U"], # basic units
	["B", "S"], ["B", "S"], # basic spells
	["B", "O"], # basic off-sites
	["B", "?"], ["B", "?"], # basic randoms
	["R", "?"], ["R", "?"], ["R", "?"], # rares
	["SR", "?"] # super-rare
]
@export var typeTotals : Array[int] = [4,4,1]

# onreadys ----------------------------
@onready var packNum : LineEdit = $PackRollText/TextEdit

var database : Dictionary
var typeCounts : Array[int] = [0,0,0]

func generate_pack() -> Array[String]:
	database = Database.instance_database()
	var pack : Array[Card] = []
	var counter : int = 1
	for arr : Array in layout:
		var card : Card = null
		print("\nrolling for card: ", counter)
		while !card || pack.has(card):
			var r : String = arr[0]
			var t : String = arr[1]
			if t == "?": t = random_type()

			if randf_range(0, 1) < 0.2:
				if r == "R": r = "SR"
				elif r == "SR": r = "DR"
			card = roll_card(
				Database.rarity_to_int[r], Database.type_to_int[t])
			
			# print out the chosen
			if card: print(r, " ", t, " ", card.name)
			else: printerr(r, " ", t, " Card could not be rolled!")
		typeCounts[card.type] += 1
		counter += 1
		pack.append(card)

	# convert cards to strings
	var output : Array[String] = []
	for c : Card in pack: output.append(
		"[color=" + Database.rareColors[c.rarity] + "] " 
		+ Database.type_to_string[c.type] + " : "+ c.name + "\n")
	return output

# gets a random card from the database
func roll_card(rarity : int = 0, type : int = 0) -> Card:
	var result : Array = database[
		Database.type_to_string[type]][
			Database.rarity_to_string[rarity]]
	result.shuffle()
	return result.pop_front()

# checks if each total has the minimum amount of cards required per type
func check_totals() -> Array[int]:
	var t : Array[int] = [0,0,0]
	for i : int in range(3): t[i] = typeTotals[i] - typeCounts[i]
	return typeTotals

# figures out which card type has the most typeTotals and returns that
func get_highest() -> int:
	var typeIDX : int = 0
	var highest : int = 0
	for i : int in range(3):
		if typeCounts[i] > highest:
			highest = typeCounts[i]
			typeIDX = i
	return typeIDX

func random_type() -> String:
	var rand : int = randi_range(0, 3)
	if rand <= 1:
		return "U"
	elif rand < 3:
		return "O"
	else:
		return "S"

# when the button is pressed, roll the cards
func _on_button_pressed() -> void:
	for n : Node in $packs.get_children(): 
		n.text = ""
	for i in int(packNum.text):
		var textField : RichTextLabel = find_child("packs").find_child(str(i+1))
		var pack : Array[String] = generate_pack()
		for s : String in pack:
			textField.text += s
