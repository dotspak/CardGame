extends Node3D
class_name Game

const HAND_OFFSET : Vector3 = Vector3(0, -13, -7.5)
const HAND_SCALE : float = 2

@onready var lifeLabel : Label = %life
@onready var lvlLabel : Label = %totalLVL
@onready var floatingLabel : Label = %floatingLVL
@onready var povPlayer : PectoBoard3D = %playerBoard
@onready var opponentPlayer : PectoBoard3D = %opponentBoard
@onready var camera : Camera3D = $Camera3D
@onready var passTurn : Button = %passButton
@onready var turnLabel : Label = %turnLabel
@onready var fader : ColorRect = %fader
@onready var border : Panel = %border

@onready var interactButtons : Control = %interactButtons
@onready var confirmButton : Button = %confirmButton
@onready var cancelButton : Button = %cancelButton

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

var currentTurn : PectoBoard3D
var turnCount : int = 0 :
	set(val):
		turnCount = val
		%turnCounter.text = "Turn Count: %s" % turnCount

func _ready():
	fade_screen(0, false)
	hide_info_box()
	border.modulate = Color.GRAY
	GameManager.gameScene = self
	GameManager.playerBoards.clear()
	GameManager.playerBoards.append(povPlayer)
	GameManager.playerBoards.append(opponentPlayer)

	defaultCamPos = camera.global_position

	povPlayer.toggle_play(false)
	povPlayer.hand.scale = Vector3.ONE * HAND_SCALE
	
	opponentPlayer.toggle_play(false)
	opponentPlayer.hand.drag_strategy.can_select = false
	opponentPlayer.hand.drag_strategy.can_remove = false
	opponentPlayer.hand.drag_strategy.can_insert = false


	povPlayer.start_game()
	await povPlayer.finishedSetup

	opponentPlayer.start_game()
	await opponentPlayer.finishedSetup

	currentTurn = povPlayer if randi_range(0, 1) == 0 else opponentPlayer
	passTurn.disabled = true

	await fade_screen(0.5, true)
	
	start_turn()


func _process(_delta) -> void:
	for c in opponentPlayer.hand.cards: c.face_down = true
	povPlayer.hand.global_position = camera.global_position + HAND_OFFSET

	if !infoHidden && Input.is_action_just_pressed("ui_cancel"):
		hide_info_box()


func fade_screen(duration : float = 0.2, fadeIn : bool = true) -> void:
	var tween := create_tween()
	tween.tween_property(fader, "modulate:a", 0 if fadeIn else 1, duration)
	await tween.finished


func start_turn() -> void:
	turnCount += 1
	if turnCount > 1: currentTurn.lvl += 1
	currentTurn.draw_card()
	currentTurn.toggle_active(true)
	update_turn_label()

	var tween := create_tween()
	if currentTurn == povPlayer:
		tween.tween_property(border, "modulate", PectoBoard3D.PLAYER_COLOR_UNIT, 0.5)
		passTurn.text = "Pass Turn"
		if passTurn.pressed.is_connected(resolve_action):
			passTurn.pressed.disconnect(resolve_action)
		passTurn.pressed.connect(end_turn)
		passTurn.disabled = false
	else:
		tween.tween_property(border, "modulate", PectoBoard3D.OPPONENT_COLOR_UNIT, 0.5)
		get_tree().create_timer(2.0).timeout.connect(end_turn)

	currentTurn.toggle_play(true)

	
func end_turn() -> void:
	print("ending %s turn" % currentTurn.name)
	currentTurn.toggle_play(false)
	passTurn.disabled = true
	passTurn.text = "Resolve"

	if currentTurn == povPlayer:
		if passTurn.pressed.is_connected(end_turn):
			passTurn.pressed.disconnect(end_turn)
		passTurn.pressed.connect(resolve_action)
	
	currentTurn = povPlayer if currentTurn == opponentPlayer else opponentPlayer

	start_turn()

func resolve_action() -> void:
	pass


func update_turn_label() -> void:
	turnLabel.hide()
	var turn : bool = currentTurn == povPlayer
	turnLabel.text = "Your Turn" if turn else "Opponent Turn"
	turnLabel.modulate = PectoBoard3D.PLAYER_COLOR_UNIT if turn else PectoBoard3D.OPPONENT_COLOR_UNIT
	turnLabel.get_child(0).stop()
	turnLabel.get_child(0).play("show")
	turnLabel.show()


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
	print("selected ", card3D.name)
	if infoHidden: await update_info_box(card3D)
	else: update_info_box(card3D)

	var buttonPos : Vector2 = camera.unproject_position(card3D.global_position)
	var buttons : Control = load("res://scenes/card_options.tscn").instantiate()

	buttons.get_child(0).visible = card3D.card.type != 1
	buttons.get_child(0).disabled = !card3D.card.active || turnCount <= 1

	buttons.get_child(1).visible = card3D.card.skillName != ""
	buttons.get_child(1).disabled = !card3D.card.active

	# temporary, change with actual logic later
	buttons.get_child(0).pressed.connect(func():
		_full_reset(card3D)
		card3D.attack())
	buttons.get_child(1).pressed.connect(func():
		_full_reset(card3D)
		card3D.use_skill())
	buttons.get_child(2).pressed.connect(_full_reset.bind(card3D))

	buttonPos.x -= 128
	for n in %cardButtons.get_children(): n.queue_free()
	
	%cardButtons.add_child(buttons)

	var tween := create_tween().set_parallel().set_trans(Tween.TRANS_SINE)
	tween.tween_property(%cardButtons, "global_position:x", buttonPos.x, 0.1).from(buttonPos.x - 50)
	tween.tween_property(%cardButtons, "modulate:a", 1, 0.1).from(0)
	%cardButtons.global_position.y = buttonPos.y


func update_info_box(card3D : PectoCard3D) -> void:
	if currentDisplayCard:
		if currentDisplayCard.card.cardName == card3D.card.cardName: return

	for n in %cardContainer.get_children(): n.queue_free()
	var card : PectoCard = card3D.card.duplicate()
	await hide_info_box(false)
	currentDisplayCard = card3D
	%cardContainer.add_child(card)
	await show_info_box()


func show_info_box(moveCam : bool = true) -> void:
	var tween := create_tween().set_trans(Tween.TRANS_SINE).set_parallel()
	tween.tween_property(%infoPanel, "position:x", 0, 0.1).from(200)
	tween.tween_property(%infoPanel, "modulate:a", 1, 0.1).from(0)
	if moveCam: tween.tween_property(camera, "position:x", 0, 0.1)
	%infoPanel.show()
	await tween.finished
	infoHidden = false


func hide_info_box(moveCam : bool = true) -> void:
	var tween := create_tween().set_trans(Tween.TRANS_SINE).set_parallel()
	tween.tween_property(%infoPanel, "position:x", 200, 0.1).from(0)
	tween.tween_property(%infoPanel, "modulate:a", 0, 0.1).from(1)
	if moveCam: tween.tween_property(camera, "position:x", -2, 0.1)
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


func _on_player_board_hand_card_selected(card3D: PectoCard3D) -> void: update_info_box(card3D)

func get_opponent(player : PectoBoard3D) -> PectoBoard3D:
	if player == povPlayer: return opponentPlayer
	else: return povPlayer

func _on_opponent_board_life_changed(val: int) -> void: %life2.text = str(val)

# sets the board to target select mode. If an empty array is returned from manual selection, 
# the target was cancelled, or no valid targets existed. Both are treated the same.
# -1 min = all are required
func select_targets(player : PectoBoard3D, targets : Array, maxTargets : int = -1, minTargets : int = -1) -> Array:
	if targets.is_empty(): return targets
	print(player)
	print(targets)

	var chosenTargets : Array = []
	passTurn.disabled = true
	passTurn.text = "Confirm Targets"

	# special targetting values
	if maxTargets == -1: maxTargets = targets.size()
	if minTargets == -1: minTargets = maxTargets

	# logic for when a player selects a card
	var addTarget = func(t):
		if targets.has(t):
			chosenTargets.append(t)
			if chosenTargets.size() >= minTargets: passTurn.disabled = false
			if chosenTargets.size() > maxTargets: chosenTargets.pop_front()

	GameManager.playerBoards[0].cardSelected.connect(addTarget)
	GameManager.playerBoards[1].cardSelected.connect(addTarget)
	await passTurn.pressed
	passTurn.text = "Pass Turn"

	return chosenTargets
