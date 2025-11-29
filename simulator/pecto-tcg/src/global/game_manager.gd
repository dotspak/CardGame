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

# func _ready(): open_database()
# func open_database() -> SQLite:
#     DB = SQLite.new()
#     DB.path = DB_PATH
#     DB.open_db()
#     return DB