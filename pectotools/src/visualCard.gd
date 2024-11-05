extends TextureRect
class_name VisualCard

var card : Card

func _init(c : Card) -> void: card = c

func _ready() -> void:
    expand_mode = EXPAND_IGNORE_SIZE
    stretch_mode = STRETCH_KEEP_ASPECT_CENTERED
    custom_minimum_size = Vector2(192, 256)
    pivot_offset = custom_minimum_size / 2
    size = custom_minimum_size
    texture = card.img
    clip_children = CLIP_CHILDREN_AND_DRAW
    mouse_entered.connect(hover)
    mouse_exited.connect(unHover)

    if card.rarity > 1:
        add_child(load("res://assets/particleMaterials/cardSparkle.tscn").instantiate())

func hover() -> void:
    create_tween().tween_property(self, "scale", Vector2(2,2), 0.1)
    z_index = 1

func unHover() -> void: 
    create_tween().tween_property(self, "scale", Vector2.ONE, 0.1)
    z_index = 0