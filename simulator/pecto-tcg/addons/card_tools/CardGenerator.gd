@tool
extends EditorPlugin

var panel

func _enter_tree() -> void:
    panel = load("res://addons/card_tools/card_generator_panel.tscn").instantiate()
    add_control_to_dock(DOCK_SLOT_RIGHT_UL, panel)
    panel.plugin = self

func _exit_tree() -> void:
    remove_control_from_docks(panel)
    panel.free()