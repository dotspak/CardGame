@tool
extends Node3D
class_name PectoBoard3D

const PLAYER_COLOR : Color = Color("7d8ced")
const OPPONENT_COLOR : Color = Color("bd3746")

const PLAYER_COLOR_UNIT : Color = Color("7d8ced")
const PLAYER_COLOR_OFFSITE : Color = Color("424a7d")
const OPPONENT_COLOR_UNIT : Color = Color("bd3746")
const OPPONENT_COLOR_OFFSITE : Color = Color("744c57")

@export_enum("Player", "Opponent") var boardSide : int = 0:
	set(val):
		boardSide = val
		for n : Node in $slotMeshes.get_children():
			var mat : StandardMaterial3D
			if n is MeshInstance3D: mat = n.get_active_material(0)
			mat.albedo_color = PLAYER_COLOR if boardSide == 0 else OPPONENT_COLOR

@export var deckToLoad : Array[String]

@onready var dragController : DragController = %DragController
@onready var hand : CardCollection3D = %Hand
@onready var deck : CardCollection3D = %Deck
@onready var discard : CardCollection3D = %Discard
@onready var cardVoid : CardCollection3D = %Void

var cardPool : Array = []
var zones : Array[GridSlot] = []
var frontRow : Array[Card3D] = [null, null, null]
var backRow : Array[Card3D] = [null, null]

var life : int = 10 :
	set(val):
		life = val
		lifeChanged.emit(life)

var lvl : int = 1 :
	set(val):
		lvl = clamp(val, 1, 99)
		lvlChanged.emit(lvl)

var floatingLVL : int = 0:
	set(val):
		floatingLVL = clamp(val, 0, 99)
		floatingLVLChanged.emit(floatingLVL)

signal lifeChanged(val : int)
signal lvlChanged(val : int)
signal floatingLVLChanged(val : int)

signal cardSelected(card : PectoCard3D)
signal handCardSelected(card : PectoCard3D)

signal finishedSetup

signal targettingComplete

func _process(_delta):
	if !Engine.is_editor_hint():
		%deckCount.text = str(deck.cards.size())
		%discardCount.text = str(discard.cards.size())
		%voidCount.text = str(cardVoid.cards.size())


func start_game() -> void:
	if deckToLoad.is_empty(): 
		deckToLoad.clear()
		var allCards : Array = GameManager.DB["cards"].keys()
		for i in 20:
			var cardID : String = allCards.pick_random()
			allCards.erase(cardID)
			deckToLoad.append(cardID)
		
	for c : Node in dragController.get_children():
		if (c.name.contains("front") || c.name.contains("back")) && c is CardCollection3D:
			zones.append(c)
			c.drag_strategy.disable_play()
			c.card_selected.connect(_on_card_selected)
			c.card_added.connect(_on_card_added_to_slot)
	load_deck()
	shuffle_deck()
	await get_tree().create_timer(0.5).timeout
	get_starting_hand()
	finishedSetup.emit()


func load_deck() -> void:
	var baseScene : PackedScene = load("uid://buocg07fg5px0")
	for cardID : String in deckToLoad:
		var card : PectoCard = GameManager.fetch_card(cardID)
		if card:
			var card3D : PectoCard3D = baseScene.instantiate()
			card3D.set_front_face(card)
			card3D.face_down = true
			cardPool.append(card3D)
			add_card_to_deck(card3D)


func get_influence() -> int: return lvl + floatingLVL
func get_highest_playable() -> int:
	var final : int = get_influence()
	for z : GridSlot in zones:
		if !z.cards.is_empty():
			if z.cards[0].get_lvl() + 1 > final:
				final = z.cards[0].get_lvl() + 1
	return final


func get_starting_hand() -> void: for _i : int in 5: draw_card()
func shuffle_deck() -> void: deck.cards.shuffle()
func recycle_deck() -> void:
	for c : Card3D in discard.cards: add_card_to_deck(c)
	shuffle_deck()


# simply draws card from top of the deck
func draw_card() -> void:
	if deck.cards.is_empty():
		if !discard.cards.is_empty(): recycle_deck()
		else: return trigger_game_lose()
			
	var cardToDraw : PectoCard3D = deck.shift_card()
	hand.append_card(cardToDraw)
	cardToDraw.collection = hand
	cardToDraw.face_down = false


func add_card_to_pile(card : PectoCard3D, pile : CardCollection3D, onTop : bool = false) -> PectoCard3D:
	var collection : CardCollection3D = card.collection
	if collection && collection.cards.has(card):
		card = collection.remove_card(collection.card_indicies[card])

	if onTop: pile.prepend_card(card)
	else: pile.append_card(card)

	card.face_down = pile == deck
	card.collection = pile
	card.hide_icons()

	return card


func add_card_to_hand(card : PectoCard3D) -> void: add_card_to_pile(card, hand)
func add_card_to_deck(card : PectoCard3D, onTop : bool = true) -> PectoCard3D: return add_card_to_pile(card, deck, onTop)
func discard_card(card : PectoCard3D) -> PectoCard3D: return add_card_to_pile(card, discard)
func void_card(card : PectoCard3D) -> PectoCard3D: return add_card_to_pile(card, cardVoid)


func _on_card_selected(card3D : PectoCard3D) -> void:
	print(card3D.collection.name)
	if !card3D.face_down:
		cardSelected.emit(card3D)
		print(card3D.card.cardName)


func _on_card_added_to_slot(card3D : PectoCard3D) -> void:
	card3D.display_icons()
	card3D.controller = self
	card3D.card._enter()
	print("card %s added at %s, max lvl now %s" % [card3D.card.cardName, get_card_coord(card3D), get_highest_playable()])


func deal_damage(amount : int) -> void: life -= amount
func heal_damage(amount : int) -> void: life += amount


func trigger_game_lose() -> void:
	print("you lose!")

func _on_hand_card_selected(card3D : PectoCard3D) -> void: handCardSelected.emit(card3D)


func toggle_play(enable : bool = true) -> void:
	print("%s play for %s" % [("disabling" if !enable else "enabling"), name])
	hand.drag_strategy.can_remove = enable
	for z : GridSlot in zones:
		if enable: z.drag_strategy.enable_play()
		else: z.drag_strategy.disable_play()


func toggle_active(enable : bool = true) -> void:
	for z : GridSlot in zones:
		if !z.cards.is_empty():
			if z.cards[0] is PectoCard3D:
				if enable: z.cards[0].make_active() 
				else: z.cards[0].make_inactive()


func get_card_coord(card3D : PectoCard3D) -> Vector2:
	var coord : Vector2 = -Vector2.INF
	if card3D.card.type != PectoCard.CARD_TYPE.Spell:
		for y in range(2):
			for x in range(3):
				var z : GridSlot = get_slot_from_coord(Vector2(x,y))
				if z && !z.cards.is_empty():
					if z.cards[0] == card3D:
						coord = Vector2(x,y)
						return coord
	return coord


func get_card(coord : Vector2 = Vector2.ZERO) -> PectoCard3D:
	var z : GridSlot = get_slot_from_coord(coord) 
	var card : PectoCard3D = null
	if !z.cards.is_empty(): card = z.cards[0]
	return card


func get_slot_from_coord(coord : Vector2 = Vector2.ZERO):
	var string : String = "%s_%s" % [("front" if int(coord.y) == 0 else "back"), str(int(coord.x))]
	var z : GridSlot = dragController.find_child(string)
	return z


func get_controlled_cards() -> Array[PectoCard3D]:
	var cards : Array[PectoCard3D]
	for z : GridSlot in zones:
		if !z.cards.is_empty():
			cards.append(z.cards[0])
	return cards
