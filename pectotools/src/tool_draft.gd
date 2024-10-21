extends Control
class_name Drafter

@export var packSize : int = 12
@export var packlayout : Dictionary = {
	# stores the guaranteed counts for rarities
	"Rarities" : {
		"Basic" : 8,
		"Rare" : 3,
		"Super-Rare" : 1,
		"Divine-Rare" : 0 },
	"Types" : [4, 4, 1]
}

@onready var packNum : LineEdit = $PackRollText/TextEdit

var typeTotals : Array[int] = [0,0,0]

func generate_pack() -> Array[String]:
	var pack : Array[Card] = []
	
	for i : int in range(packSize):
		var card : Card = null
		
		# keep rolling cards until the pack does not have duplicates
		while !card || pack.has(card):
			var type : int = randi_range(0,2)
			# handles basic cards
			if i < 8: 
				card = roll_card(0, type)
			
			# handles rares
			elif i < 11:
				if i == 10:
					var rand : float = randf_range(0, 1.0)
					if rand < 0.3: 
						card = roll_card(3, type)
						continue
					if rand < 0.5:
						card = roll_card(2, type)
						continue
				roll_card(1)
			
			# handles super-rare / divine-rare
			else:
				if randf_range(0, 1.0) < 0.3: 
					card = roll_card(3, type)
				else: 
					card = roll_card(2, type)
		typeTotals[card.card_type] += 1
		pack.append(card)
	
	# balances the card types
	var types = check_totals()
	while types[0] > 0 || types[1] > 0 || types[2] > 0:
		# determine which type needs to be increased
		var highestType : int = get_highest()
		var target : int = 0
		for i in range(types.size()):
			if types[i] > 0:
				target = i

		# change card if it is a type that is too high
		for i in range(packSize):
			if pack[i].card_type == highestType:
				if randf_range(0, 1.0) < 0.5:
					pack[i] = roll_card(pack[i].rarity, target)

	# convert cards to strings
	var output : Array[String] = []
	for c : Card in pack: 
		output.append("[color=" + Database.rareColors[c.rarity] + "]" + c.name + "\n")
	return output

# gets a random card from the database
func roll_card(rarity : int = 0, type : int = 0) -> Card:
	return Database.rand_search(type, rarity)

# checks if each total has the minimum amount of cards required per type
func check_totals() -> Array[int]:
	var types : Array[int] = [0,0,0]
	for i : int in range(3):
		types[i] = packlayout["Types"][i] - typeTotals[i]
	return types

# figures out which card type has the most types and returns that
func get_highest() -> int:
	var typeIDX : int = 0
	var highest : int = 0
	for i : int in range(3):
		if typeTotals[i] > highest:
			highest = typeTotals[i]
			typeIDX = i
	return typeIDX

# when the button is pressed, roll the cards
func _on_button_pressed() -> void:
	for n : Node in $packs.get_children(): 
		n.text = ""
	for i in int(packNum.text):
		var textField : RichTextLabel = find_child("packs").find_child(str(i+1))
		var pack : Array[String] = generate_pack()
		for s : String in pack:
			textField.text += s

