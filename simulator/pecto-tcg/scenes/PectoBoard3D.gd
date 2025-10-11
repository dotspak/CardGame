@tool
extends Node3D
class_name PectoBoard3D

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
			if n.name.contains("unit"):
				mat.albedo_color = PLAYER_COLOR_UNIT \
					if boardSide == 0 else OPPONENT_COLOR_UNIT
			elif n.name.contains("offsite"):
				mat.albedo_color = PLAYER_COLOR_OFFSITE \
					if boardSide == 0 else OPPONENT_COLOR_OFFSITE

@export var deckToLoad : Array[String]

@onready var dragController : DragController = %DragController
@onready var hand : CardCollection3D = %Hand
@onready var deck : CardCollection3D = %Deck
@onready var discard : CardCollection3D = %Discard
@onready var cardVoid : CardCollection3D = %Void
@onready var playZone : CardCollection3D = %PlayZone

var cardPool : Array = []
var slots : Array[GridSlot] = []

var units : Array[Card3D] = [null, null, null]
var offsites : Array[Card3D] = [null, null, null]

var life : int = 10 :
	set(val):
		life = val
		lifeChanged.emit(life)

var lvl : int = 1 :
	set(val):
		lvl = clamp(val, 1, 99)
		#lvlChanged.emit(lvl)

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

func _process(_delta):
	if !Engine.is_editor_hint():
		%deckCount.text = str(deck.cards.size())
		%discardCount.text = str(discard.cards.size())
		%voidCount.text = str(cardVoid.cards.size())

func start_game() -> void:
	if deckToLoad.is_empty(): return
	for c : Node in dragController.get_children():
		if (c.name.contains("unit") || c.name.contains("offsite")) && c is CardCollection3D:
			slots.append(c)
			c.drag_strategy.disable_play()
			c.board = self
			c.card_selected.connect(_on_card_selected)
			c.card_added.connect(_on_card_added_to_slot)
	playZone.drag_strategy.disable_play()
	load_deck()
	shuffle_deck()
	await get_tree().create_timer(0.5).timeout
	get_starting_hand()
	finishedSetup.emit()


func load_deck() -> void:
	var baseScene : PackedScene = load("uid://buocg07fg5px0")
	var db : SQLite = SQLite.new()
	db.path = PectoCard.DB_PATH
	db.open_db()
	for cardID : String in deckToLoad:
		var card : PectoCard = fetch_card(cardID, db)
		if card:
			var card3D : PectoCard3D = baseScene.instantiate()
			card3D.set_front_face(card)
			card3D.face_down = true
			cardPool.append(card3D)
			
			add_card_to_deck(card3D)
	db.close_db()


func fetch_card(cardID : String, db : SQLite) -> PectoCard:
	var card : PectoCard = null
	db.query_with_bindings("SELECT scene FROM pecto_set1 WHERE ID=?;", [cardID])
	if db.query_result.size() > 0: card = load(db.query_result[0]["scene"]).instantiate()
	return card


func get_influence() -> int: return lvl + floatingLVL


func get_starting_hand() -> void:
	var lvl1cards : Array[PectoCard3D] = []
	for c : PectoCard3D in cardPool:
		if c.card.lvl == 1 && c.card.type != PectoCard.CARD_TYPE.Spell:
			lvl1cards.append(c)
			print(c.name)

	add_card_to_hand(lvl1cards.pick_random())
	for _i : int in 4: draw_card()


func recycle_deck() -> void:
	for c : Card3D in discard.cards: add_card_to_deck(c)
	shuffle_deck()


func shuffle_deck() -> void: deck.cards.shuffle()

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
	if card3D.collection is GridSlot:
		if !card3D.face_down:
			cardSelected.emit(card3D)
			print(card3D.card.cardName)


func _on_card_added_to_slot(card3D : PectoCard3D) -> void:
	card3D.display_icons()
	card3D.controller = self
	var startingLvl : int = lvl
	lvl = 0
	for slot : CardCollection3D in slots:
		if !slot.cards.is_empty():
			var c : PectoCard3D = slot.cards[0]
			c.collection = slot
			lvl += c.card.lvl if !c.card.banished else 0
	if startingLvl != lvl: lvlChanged.emit(lvl)
	card3D.card._enter()
	print("card %s added at %s, lvl now %s" % [card3D.card.cardName, get_card_coord(card3D), lvl])


func deal_damage(amount : int) -> void: life -= amount
func heal_damage(amount : int) -> void: life += amount


func trigger_game_lose() -> void:
	print("you lose!")


func _on_play_zone_card_added(card: PectoCard3D) -> void:
	card.collection = playZone
	playZone.drag_strategy.can_select = false
	hand.drag_strategy.can_select = false
	
	var isSpell : bool = card.card.type == PectoCard.CARD_TYPE.Spell
	await get_tree().create_timer(0.5).timeout
	if isSpell: card = discard_card(card)
	else:
		for slot : GridSlot in slots:
			if slot.drag_strategy.can_insert_card(card, slot, playZone):
				slot.highlight_slot()

	if !isSpell:
		await get_tree().create_timer(2.0).timeout
		card = playZone.remove_card(playZone.card_indicies[card])
		add_card_to_hand(card)
		for slot : GridSlot in slots: slot.unhighlight_slot()
	
	hand.drag_strategy.can_select = true
	playZone.drag_strategy.can_select = true


func _on_hand_card_selected(card3D : PectoCard3D) -> void: handCardSelected.emit(card3D)


func toggle_play(enable : bool = true) -> void:
	print("%s play for %s" % [("disabling" if !enable else "enabling"), name])
	hand.drag_strategy.can_remove = enable
	if enable: playZone.drag_strategy.enable_play()
	else: playZone.drag_strategy.disable_play()
	for slot : GridSlot in slots:
		if enable: slot.drag_strategy.enable_play()
		else: slot.drag_strategy.disable_play()


func toggle_active(enable : bool = true) -> void:
	for slot : GridSlot in slots:
		if !slot.cards.is_empty():
			if slot.cards[0] is PectoCard3D:
				if enable: slot.cards[0].make_active() 
				else: slot.cards[0].make_inactive()


func get_card_coord(card3D : PectoCard3D) -> Vector2:
	var coord : Vector2 = -Vector2.INF
	if card3D.card.type != PectoCard.CARD_TYPE.Spell:
		for y in range(2):
			for x in range(3):
				var slot : GridSlot = get_slot_from_coord(Vector2(x,y))
				if !slot.cards.is_empty():
					if slot.cards[0] == card3D:
						coord = Vector2(x,y)
						break
	return coord


func get_card(coord : Vector2 = Vector2.ZERO) -> PectoCard3D:
	var slot : GridSlot = get_slot_from_coord(coord) 
	var card : PectoCard3D = null
	if !slot.cards.is_empty(): card = slot.cards[0]
	return card


func get_slot_from_coord(coord : Vector2 = Vector2.ZERO):
	var string : String = "%s_%s" % [("unit" if int(coord.y) == 0 else "offsite"), int(coord.x)]
	var slot : GridSlot = dragController.find_child(string)
	return slot
