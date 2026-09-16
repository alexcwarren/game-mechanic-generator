extends Control

@export var start_scene: PackedScene

@onready var _title_label: Label = %TitleLabel
@onready var _start_button: Button = %StartButton
@onready var _quit_button: Button = %QuitButton


func _ready() -> void:
	DebugLog.log_info(self, "ready")
	_title_label.text = str(
		ProjectSettings.get_setting("application/config/name", "Game Title")
	)
	_start_button.pressed.connect(_start_button_pressed)
	_quit_button.pressed.connect(_quit_button_pressed)
	_start_button.grab_focus()


func _start_button_pressed() -> void:
	if start_scene == null:
		var err_msg: String = "Start Scene is empty."
		push_error(err_msg)
		DebugLog.log_error(self, err_msg)
		var err_dialog := ErrorDialog.new(err_msg, self, _quit)
		return
	get_tree().change_scene_to_packed(start_scene)


func _quit_button_pressed() -> void:
	_quit()


func _quit() -> void:
	get_tree().quit()
