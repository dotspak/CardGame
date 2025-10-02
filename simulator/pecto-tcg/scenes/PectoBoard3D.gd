extends Node3D
class_name PectoBoard3D

@export var deck : Array[String]

@onready var bluePlayerDragController : DragController = %DragController
@onready var bluePlayerHand : CardCollection3D = %Hand
@onready var bluePlayerDeck : CardCollection3D = %Deck
@onready var bluePlayerDiscard : CardCollection3D = %Discard
@onready var bluePlayerVoid : CardCollection3D = %Void

@onready var camera : Camera3D = %Camera3D

var defaultCamPos : Vector3
var bluePlayerCardPool : Dictionary = {}
var slots : Array[CardCollection3D] = []

var lvl : int = 1 :
	set(val):
		lvl = clamp(val, 1, 99)
		lvlChanged.emit(lvl)
		update_lvl()

var floatingLVL : int = 0:
	set(val):
		floatingLVL = clamp(val, 0, 99)
		floatingLVLChanged.emit(floatingLVL)

signal lvlChanged(val : int)
signal floatingLVLChanged(val : int)

func _ready() -> void:
	defaultCamPos = camera.global_position
	var skipNodes : Array[String] = ["Hand", "Deck", "Discard", "Void"]
	for c : Node in bluePlayerDragController.get_children():
		if !skipNodes.has(c.name) && c is CardCollection3D:
			slots.append(c)
			c.board = self
			c.card_selected.connect(_on_card_selected)
			c.card_added.connect(_on_card_added)

	load_deck(0)
	shuffle_deck()
	await get_tree().create_timer(0.5).timeout
	get_starting_hand()


func load_deck(_player : int = 0) -> void:
	var baseScene : PackedScene = load("uid://buocg07fg5px0")
	var db : SQLite = SQLite.new()
	db.path = PectoCard.DB_PATH
	db.open_db()
	for cardID : String in deck:
		var card : PectoCard = fetch_card(cardID, db)
		if card:
			var card3D : PectoCard3D = baseScene.instantiate()
			card3D.set_front_face(card)
			card3D.face_down = true
			bluePlayerDeck.append_card(card3D)
			
			bluePlayerCardPool[cardID] = {}
			bluePlayerCardPool[cardID]["node"] = card3D
			bluePlayerCardPool[cardID]["idx"] = bluePlayerDeck.cards.find(card3D)
			bluePlayerCardPool[cardID]["collection"] = bluePlayerDeck
	db.close_db()


func fetch_card(cardID : String, db : SQLite) -> PectoCard:
	var card : PectoCard = null
	db.query_with_bindings("SELECT scene FROM pecto_set1 WHERE ID=?;", [cardID])
	if db.query_result.size() > 0: card = load(db.query_result[0]["scene"]).instantiate()
	return card


func get_influence() -> int: return lvl + floatingLVL

func get_starting_hand() -> void:
	var lvl1cards : Array[String] = []
	for key : String in bluePlayerCardPool.keys():
		var c : PectoCard3D = bluePlayerCardPool[key]["node"]
		if c.card.lvl == 1 && c.card.type != PectoCard.CARD_TYPE.Spell:
			lvl1cards.append(key)
	
	add_card_to_hand(lvl1cards.pick_random())
	for _i : int in 4: draw_card()
	

func add_card_to_hand(cardID : String) -> void:
	var collection : CardCollection3D = bluePlayerCardPool[cardID]["collection"]
	var card : PectoCard3D = bluePlayerCardPool[cardID]["node"]
	if collection: card = collection.remove_card(bluePlayerCardPool[cardID]["idx"])
	bluePlayerHand.append_card(card)
	card.face_down = false
	bluePlayerCardPool[cardID]["collection"] = bluePlayerHand


# simply draws card from top of deck
func draw_card() -> void:
	var cardToDraw : PectoCard3D = bluePlayerDeck.shift_card()
	bluePlayerHand.append_card(cardToDraw)
	cardToDraw.face_down = false


func shuffle_deck() -> void: bluePlayerDeck.cards.shuffle()


func add_card_to_deck(cardID : String, onTop : bool = true) -> void:
	var collection : CardCollection3D = bluePlayerCardPool[cardID]["collection"]
	var card : PectoCard3D = bluePlayerCardPool[cardID]["node"]
	if collection: card = collection.remove_card(bluePlayerCardPool[cardID]["idx"])

	if onTop: bluePlayerDeck.prepend_card(card)
	else: bluePlayerDeck.append_card(card)

	card.face_down = true
	bluePlayerCardPool[cardID]["collection"] = bluePlayerDeck


func discard_card(cardID : String) -> void: 
	var collection : CardCollection3D = bluePlayerCardPool[cardID]["collection"]
	var card : PectoCard3D = bluePlayerCardPool[cardID]["node"]
	if collection: card = collection.remove_card(bluePlayerCardPool[cardID]["idx"])
	bluePlayerDiscard.append_card(card)
	card.face_down = false
	bluePlayerCardPool[cardID]["collection"] = bluePlayerDiscard


func void_card(cardID : String) -> void: 
	var collection : CardCollection3D = bluePlayerCardPool[cardID]["collection"]
	var card : PectoCard3D = bluePlayerCardPool[cardID]["node"]
	if collection: card = collection.remove_card(bluePlayerCardPool[cardID]["idx"])
	bluePlayerVoid.append_card(card)
	card.face_down = false
	bluePlayerCardPool[cardID]["collection"] = bluePlayerVoid


func _on_card_selected(card3D : PectoCard3D) -> void:
	print(card3D.card.cardName)

func _on_card_added(card3D : PectoCard3D) -> void:
	lvl = 0
	unhighlight_slots()
	for slot : CardCollection3D in slots:
		if !slot.cards.is_empty():
			var c : PectoCard3D = slot.cards[0]
			lvl += c.card.lvl if !c.card.banished else 0
	print("card %s added, lvl now %s" % [card3D.card.cardName, lvl])


func update_lvl() -> void:
	var factor : float = 2
	var tween := create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(%totalLVL, "scale", Vector2.ONE * factor, 0.04)
	tween.tween_property(%totalLVL, "scale", Vector2.ONE, 0.04)
	%totalLVL.text = str(get_influence())


func unhighlight_slots() -> void: for slot : CardCollection3D in slots: slot.unhighlight_slot()
