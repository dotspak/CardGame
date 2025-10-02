@tool
extends Node3D
class_name PectoBoard3D

const PLAYER_COLOR_UNIT : Color = Color("424a7d")
const PLAYER_COLOR_OFFSITE : Color = Color("2b3051")

const OPPONENT_COLOR_UNIT : Color = Color("744c57")
const OPPONENT_COLOR_OFFSITE : Color = Color("4e333b")

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

@onready var camera : Camera3D = %Camera3D

var defaultCamPos : Vector3
var cardPool : Dictionary = {}
var slots : Array[CardCollection3D] = []

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

func _ready() -> void: if !Engine.is_editor_hint(): start_game()
	

func start_game() -> void:
	defaultCamPos = camera.global_position
	var skipNodes : Array[String] = ["Hand", "Deck", "Discard", "Void"]
	for c : Node in dragController.get_children():
		if !skipNodes.has(c.name) && c is CardCollection3D:
			slots.append(c)
			c.board = self
			c.card_selected.connect(_on_card_selected)
			c.card_added.connect(_on_card_added)

	load_deck()
	shuffle_deck()
	await get_tree().create_timer(0.5).timeout
	get_starting_hand()


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
			deck.append_card(card3D)
			
			cardPool[cardID] = {}
			cardPool[cardID]["node"] = card3D
			cardPool[cardID]["idx"] = deck.cards.find(card3D)
			cardPool[cardID]["collection"] = deck
	db.close_db()


func fetch_card(cardID : String, db : SQLite) -> PectoCard:
	var card : PectoCard = null
	db.query_with_bindings("SELECT scene FROM pecto_set1 WHERE ID=?;", [cardID])
	if db.query_result.size() > 0: card = load(db.query_result[0]["scene"]).instantiate()
	return card


func get_influence() -> int: return lvl + floatingLVL

func get_starting_hand() -> void:
	var lvl1cards : Array[String] = []
	for key : String in cardPool.keys():
		var c : PectoCard3D = cardPool[key]["node"]
		if c.card.lvl == 1 && c.card.type != PectoCard.CARD_TYPE.Spell:
			lvl1cards.append(key)
	
	add_card_to_hand(lvl1cards.pick_random())
	for _i : int in 4: draw_card()
	

func add_card_to_hand(cardID : String) -> void:
	var collection : CardCollection3D = cardPool[cardID]["collection"]
	var card : PectoCard3D = cardPool[cardID]["node"]
	if collection: card = collection.remove_card(cardPool[cardID]["idx"])
	hand.append_card(card)
	card.face_down = false
	cardPool[cardID]["collection"] = hand


# simply draws card from top of deckToLoad
func draw_card() -> void:
	var cardToDraw : PectoCard3D = deck.shift_card()
	hand.append_card(cardToDraw)
	cardToDraw.face_down = false


func shuffle_deck() -> void: deck.cards.shuffle()


func add_card_to_deck(cardID : String, onTop : bool = true) -> void:
	var collection : CardCollection3D = cardPool[cardID]["collection"]
	var card : PectoCard3D = cardPool[cardID]["node"]
	if collection: card = collection.remove_card(cardPool[cardID]["idx"])

	if onTop: deck.prepend_card(card)
	else: deck.append_card(card)

	card.face_down = true
	cardPool[cardID]["collection"] = deck


func discard_card(cardID : String) -> void: 
	var collection : CardCollection3D = cardPool[cardID]["collection"]
	var card : PectoCard3D = cardPool[cardID]["node"]
	if collection: card = collection.remove_card(cardPool[cardID]["idx"])
	discard.append_card(card)
	card.face_down = false
	cardPool[cardID]["collection"] = discard


func void_card(cardID : String) -> void: 
	var collection : CardCollection3D = cardPool[cardID]["collection"]
	var card : PectoCard3D = cardPool[cardID]["node"]
	if collection: card = collection.remove_card(cardPool[cardID]["idx"])
	cardVoid.append_card(card)
	card.face_down = false
	cardPool[cardID]["collection"] = cardVoid


func _on_card_selected(card3D : PectoCard3D) -> void:
	print(card3D.card.cardName)

func _on_card_added(card3D : PectoCard3D) -> void:
	var startingLvl : int = lvl
	lvl = 0
	for slot : CardCollection3D in slots:
		if !slot.cards.is_empty():
			var c : PectoCard3D = slot.cards[0]
			lvl += c.card.lvl if !c.card.banished else 0
	
	if startingLvl != lvl:
		lvlChanged.emit(lvl)
	print("card %s added, lvl now %s" % [card3D.card.cardName, lvl])



func deal_damage(amount : int) -> void: life -= amount
func heal_damage(amount : int) -> void: life += amount
