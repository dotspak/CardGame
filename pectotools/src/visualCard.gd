extends TextureRect
class_name VisualCard

var card : Card

func _init(c : Card) -> void: card = c

func _ready() -> void:
    expand_mode = EXPAND_IGNORE_SIZE
    stretch_mode = STRETCH_KEEP_ASPECT_CENTERED
    custom_minimum_size = Vector2(192, 256)
    size = custom_minimum_size
    texture = card.img
