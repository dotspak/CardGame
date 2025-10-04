extends Node3D
class_name Game

const HAND_OFFSET : Vector3 = Vector3(0, -3.5, -7.5)

@onready var lifeLabel : Label = %life
@onready var lvlLabel : Label = %totalLVL
@onready var floatingLabel : Label = %floatingLVL
@onready var povPlayer : PectoBoard3D = %playerBoard
@onready var opponentPlayer : PectoBoard3D = %opponentBoard
@onready var camera : Camera3D = $Camera3D

var defaultCamPos : Vector3 = Vector3.ZERO

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



func _ready(): 
	GameManager.gameScene = self
	GameManager.playerBoards.clear()
	GameManager.playerBoards.append(povPlayer)
	GameManager.playerBoards.append(opponentPlayer)

	defaultCamPos = camera.global_position

func _process(_delta) -> void:
	povPlayer.hand.global_position = camera.global_position + HAND_OFFSET

func update_life(val : int) -> void:
	var time : float = abs(val - currentLife) * 0.1
	var tween := create_tween()
	tween.tween_property(self, "currentLife", val, time)


func update_lvl(val : int) -> void:
	var time : float = abs(val - currentLvl) * 0.1
	var tween := create_tween()
	tween.tween_property(self, "currentLvl", val, time)


func update_floatingLVl(val : int) -> void:
	var time : float = abs(val - currentFloating) * 0.1
	var tween := create_tween()
	tween.tween_property(self, "currentFloating", val, time)


func animate_icon(node : Control) -> void:
	var factor : float = 1.5
	var tween := create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(node, "scale", Vector2.ONE * factor, 0.04)
	tween.tween_property(node, "scale", Vector2.ONE, 0.04)


func _on_player_card_selected(card: Card3D) -> void:
	var tween := create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(camera, "global_position", 
		Vector3(card.global_position.x, card.global_position.y - 2, 
			defaultCamPos.z - 6), 0.1)

	await tween.finished

	var buttonPos : Vector2 = camera.unproject_position(card.global_position)
	var buttons : Control = load("res://scenes/card_options.tscn").instantiate()

	buttons.get_child(0).visible = card.card.type != 1
	buttons.get_child(0).disabled = !card.card.active

	buttons.get_child(1).visible = card.card.skillName != ""
	buttons.get_child(1).disabled = !card.card.active

	# temporary, change with actual logic later
	buttons.get_child(0).pressed.connect(func():
		await _full_reset(card)
		card.attack())
	buttons.get_child(1).pressed.connect(func():
		await _full_reset(card)
		card.use_skill())
	buttons.get_child(2).pressed.connect(_full_reset.bind(card))

	buttonPos.x -= 128
	for n in %cardButtons.get_children(): n.queue_free()
	
	%cardButtons.add_child(buttons)
	%cardButtons.global_position = buttonPos


func clear_buttons() -> void: for n in %cardButtons.get_children(): n.queue_free()


func reset_camera() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(camera, "global_position", defaultCamPos, 0.1) 
	await tween.finished


func trigger_interaction_layer(_player : int = 1) -> void:
	pass


func _full_reset(_card: Variant) -> void:
	clear_buttons()
	await reset_camera()
