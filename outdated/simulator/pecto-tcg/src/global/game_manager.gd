extends Node

const DB_PATH : String = "res://data/pectoDB.json"

var gameScene : Game
var playerBoards : Array[PectoBoard3D]

var DB : Dictionary = {}

func _ready(): load_DB()
func load_DB() -> void:
	if FileAccess.file_exists(DB_PATH):
		var file : FileAccess = FileAccess.open(DB_PATH, FileAccess.READ)
		DB = JSON.parse_string(file.get_as_text())
	else:
		printerr("File Doesn't Exist!")

func save_DB() -> void:
	var file := FileAccess.open(DB_PATH, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(DB, "\t")) # pretty print
		file.close()
		print("Database saved to ", DB_PATH)
	else:
		push_error("Failed to save card DB to: " + DB_PATH)


func fetch_card(cardID : String) -> PectoCard:
	var card : PectoCard = null
	if DB["cards"][cardID]:
		var cardSet : String = DB["cards"][cardID]["set"]
		var fileName : String = "res://data/cards/%s/%s.tscn"% [cardSet, cardID]
		card = load(fileName).instantiate()
	return card
