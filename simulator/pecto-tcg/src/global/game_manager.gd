extends Node

const DB_PATH : String = "res://data/pectoDB.db"

var gameScene : Game
var playerBoards : Array[PectoBoard3D]

var DB : SQLite

func _ready(): open_database()
func open_database() -> SQLite:
    DB = SQLite.new()
    DB.path = DB_PATH
    DB.open_db()
    return DB