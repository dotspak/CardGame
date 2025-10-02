extends Node3D
class_name Game

@onready var lifeLabel : Label = %life
@onready var lvlLabel : Label = %totalLVL
@onready var floatingLabel : Label = %floatingLVL

@onready var camera : Camera3D = $Camera3D

var currentLife : int = 10 :
    set(val):
        if val != currentLife: animate_icon(lifeLabel)
        currentLife = val
        lifeLabel.text = str(currentLife)
        

var currentLvl : int = 1 :
    set(val):
        if val != currentLvl: animate_icon(lvlLabel)
        currentLvl = clamp(val, 1, 99)
        lvlLabel.text = str(currentLvl)
        

var currentFloating : int = 0 :
    set(val):
        if val != currentFloating: animate_icon(floatingLabel)
        currentFloating = clamp(val, 0, 99)
        floatingLabel.text = str(currentFloating)
       


func update_life(val : int) -> void:
    var tween := create_tween()
    tween.tween_property(self, "currentLife", val, 0.1)


func update_lvl(val : int) -> void:
    var tween := create_tween()
    tween.tween_property(self, "currentLvl", val, 0.1)


func update_floatingLVl(val : int) -> void:
    var tween := create_tween()
    tween.tween_property(self, "currentFloating", val, 0.1)


func animate_icon(node : Control) -> void:
    var factor : float = 1.5
    var tween := create_tween().set_trans(Tween.TRANS_SINE)
    tween.tween_property(node, "scale", Vector2.ONE * factor, 0.04)
    tween.tween_property(node, "scale", Vector2.ONE, 0.04)

func _on_player_card_selected(card: Card3D) -> void:
    var buttonPos : Vector2 = camera.unproject_position(card.global_position)
    var buttons : Control = load("res://scenes/card_options.tscn").instantiate()

    if %cardButtons.get_child_count() > 0:
        %cardButtons.get_child(0).queue_free()
    
    %cardButtons.add_child(buttons)
    buttons.global_position = buttonPos
