@tool
extends Control
class_name CardGenerator

const JSON_PATH : String = "res://data/pectoDB.json"
const BASE_SCENE : String = "res://scenes/cardTemplates/card_pectoCard.tscn"
const TEMPLATE_SCENE : String = "res://scenes/cardTemplates/card_visuals.tscn"

@onready var setInput : LineEdit = %setInput
@onready var generateButton : Button = %generateButton
@onready var outputLog : RichTextLabel = %outputLog
@onready var skipButton : CheckBox = %skipDupe

var plugin
var DB : Dictionary = {}

func _on_generate_pressed():
    var setName = setInput.text.strip_edges()
    if setName == "":
        _log("Set name cannot be empty.")
        return
    
    var cardData = _load_json()["cards"]
    if cardData.is_empty():
        _log("No data found in DB")
        return
    
    var matchingCards = []
    for cardID : String in cardData.keys():
        if cardData[cardID]["set"] == setName:
            matchingCards.append(cardID)
    
    if matchingCards.is_empty():
        _log("No cards found for set '%s'" % setName)
        return
    
    var setFolder = "res://data/cards/%s" % setName
    _ensure_folder(setFolder)

    for id in matchingCards:
        _create_scene(id, cardData[id], setFolder)
    
    _log("Finished generating %d scenes." % matchingCards.size())


func _ensure_folder(folder : String) -> void:
    var dir := DirAccess.open("res://")
    if not dir.dir_exists(folder):
        dir.make_dir_recursive(folder)


func _load_json() -> Dictionary:
    var file := FileAccess.open(JSON_PATH, FileAccess.READ)
    if !file: return {}
    DB = JSON.parse_string(file.get_as_text())
    return DB


func _create_scene(ID : String, data : Dictionary, folder : String) -> void:
    var savePath = "%s/%s.tscn" % [folder, ID]
    var card : PectoCard

    # find the card if it exists, create a new one if not
    if FileAccess.file_exists(savePath):
        if skipButton.pressed: return
        card = load(savePath).instantiate()
        _log("Updating %s (existing scene)" % ID)
    else:
        card = PectoCard.new()
        _log("Creating new card: %s" % ID)

    # load the card data
    card.db = DB
    card.data = data
    card.ID = ID
    card.name = ID

    if "update_card_data" in card: card.update_card_data(false)
    else: _log("Base Scene missing update_card_data()")

    # pack the scene and save it
    var packed : PackedScene = PackedScene.new()
    packed.pack(card)
    ResourceSaver.save(packed, savePath)


func _log(msg : String): outputLog.append_text(msg + "\n")
func _on_clear_log_pressed() -> void: outputLog.text = ""
