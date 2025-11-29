@tool
extends Control

var plugin
const JSON_PATH : String = "res://data/pectoDB.json"
const BASE_SCENE : String = "res://scenes/cardTemplates/card_pectoCard.tscn"

@onready var setInput : LineEdit = %setInput
@onready var generateButton : Button = %Button
@onready var outputLog : RichTextLabel = %outputLog

func _ready(): generateButton.pressed.connect(_on_generate_pressed)
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
    return JSON.parse_string(file.get_as_text())


func _create_scene(ID : String, data : Dictionary, folder : String) -> void:
    var savePath = "%s/%s.tscn" % [folder, ID]
    if FileAccess.file_exists(savePath):
        _log("Skipped %s - already exists" % ID)
        return

    var base = load(BASE_SCENE).instantiate()
    base.data = data
    base.ID = ID
    if "update_card_data" in base:
        base.update_card_data(false)
    else:
        _log("Base Scene missing update_card_data()")
    
    var packed : PackedScene = PackedScene.new()
    packed.pack(base)
    ResourceSaver.save(packed, savePath)


func _log(msg : String):
    outputLog.append_text(msg + "\n")
