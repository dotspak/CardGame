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

var currentDisplayCard : PectoCard3D = null
var infoHidden : bool = true


func _ready(): 
	hide_info_box()
	GameManager.gameScene = self
	GameManager.playerBoards.clear()
	GameManager.playerBoards.append(povPlayer)
	GameManager.playerBoards.append(opponentPlayer)

	defaultCamPos = camera.global_position

func _process(_delta) -> void:
	povPlayer.hand.global_position = camera.global_position + HAND_OFFSET

	if !infoHidden && Input.is_action_just_pressed("ui_cancel"):
		hide_info_box()

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


func _on_player_card_selected(card3D: Card3D) -> void:
	update_info_box(card3D)
	var tween := create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(camera, "global_position", 
		Vector3(card3D.global_position.x, card3D.global_position.y - 2, 
			defaultCamPos.z - 6), 0.1)

	await tween.finished

	var buttonPos : Vector2 = camera.unproject_position(card3D.global_position)
	var buttons : Control = load("res://scenes/card_options.tscn").instantiate()

	buttons.get_child(0).visible = card3D.card.type != 1
	buttons.get_child(0).disabled = !card3D.card.active

	buttons.get_child(1).visible = card3D.card.skillName != ""
	buttons.get_child(1).disabled = !card3D.card.active

	# temporary, change with actual logic later
	buttons.get_child(0).pressed.connect(func():
		await _full_reset(card3D)
		card3D.attack())
	buttons.get_child(1).pressed.connect(func():
		await _full_reset(card3D)
		card3D.use_skill())
	buttons.get_child(2).pressed.connect(_full_reset.bind(card3D))

	buttonPos.x -= 128
	for n in %cardButtons.get_children(): n.queue_free()
	
	%cardButtons.add_child(buttons)
	%cardButtons.global_position = buttonPos


func update_info_box(card3D : PectoCard3D) -> void:
	if currentDisplayCard:
		if currentDisplayCard.card.cardName == card3D.card.cardName: 
			return

	var card : PectoCard = card3D.card
	await hide_info_box()
	currentDisplayCard = card3D

	%infoName.text = card.get_card_name()
	%infoArt.texture = card.get_card_art()
	%infoText.text = card.get_card_text()
	%infoSkill.text = card.get_card_skill()
	%infoKeyword.text = card.get_card_keyword_text()
	%infoKeyword.visible = !card.keywords.is_empty()

	await show_info_box()


func show_info_box() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_SINE).set_parallel()
	tween.tween_property(%infoPanel, "position:x", 0, 0.1).from(200)
	tween.tween_property(%infoPanel, "modulate:a", 1, 0.1).from(0)
	%infoPanel.show()
	await tween.finished
	infoHidden = false


func hide_info_box() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_SINE).set_parallel()
	tween.tween_property(%infoPanel, "position:x", 200, 0.1).from(0)
	tween.tween_property(%infoPanel, "modulate:a", 0, 0.1).from(1)
	await tween.finished
	%infoPanel.hide()
	infoHidden = true
	currentDisplayCard = null


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


func _on_player_board_hand_card_selected(card3D: PectoCard3D) -> void: update_info_box(card3D)
