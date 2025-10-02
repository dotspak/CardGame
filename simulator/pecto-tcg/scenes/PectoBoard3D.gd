extends Node3D
class_name PectoBoard3D

@export var deck : Array[String]

@onready var bluePlayerHand : CardCollection3D = %Hand

func _ready() -> void:
    load_deck(0)

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
            bluePlayerHand.append_card(card3D)
    db.close_db()


func fetch_card(cardID : String, db : SQLite) -> PectoCard:
    var card : PectoCard = null
    db.query_with_bindings("SELECT scene FROM pecto_set1 WHERE ID=?;", [cardID])
    if db.query_result.size() > 0: card = load(db.query_result[0]["scene"]).instantiate()
    return card


func shuffle_deck() -> void:
    pass


func draw_card() -> void:
    pass


func discard_card() -> void:
    pass


func void_card() -> void:
    pass