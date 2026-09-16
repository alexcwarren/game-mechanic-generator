extends Node

@export var debug_log_enabled: bool = false
@export var debug_log_level: DebugLog.Level = DebugLog.Level.ERROR
@export var container_button: PackedScene

@onready var verb_label: Label = %VerbLabel
@onready var constraint_label: Label = %ConstraintLabel
@onready var goal_label: Label = %GoalLabel
@onready var pressure_label: Label = %PressureLabel

@onready var verb_check: CheckButton = %VerbCheckButton
@onready var constraint_check: CheckButton = %ConstraintCheckButton
@onready var goal_check: CheckButton = %GoalCheckButton
@onready var pressure_check: CheckButton = %PressureCheckButton

@onready var decision_edit: TextEdit = %DecisionTextEdit

@onready var randomize_button: Button = %RandomizeButton
@onready var export_button: Button = %ExportButton

@onready var verb_container: Container = %VerbContainer
@onready var constraint_container: Container = %ConstraintContainer
@onready var goal_container: Container = %GoalContainer
@onready var pressure_container: Container = %PressureContainer

const VERB: String = "verb"
const CONSTRAINT: String = "constraint"
const GOAL: String = "goal"
const PRESSURE: String = "pressure"

var verbs: PackedStringArray = [
	"Move",
	"Jump",
	"Dash",
	"Dodge",
	"Shoot",
	"Throw",
	"Push",
	"Pull",
	"Grab",
	"Carry",
	"Drop",
	"Place",
	"Rotate",
	"Swap",
	"Connect",
	"Break",
	"Build",
	"Block",
	"Hide",
	"Reveal",
	"Collect",
	"Deliver",
	"Charge",
	"Freeze",
	"Rewind",
	"Switch",
]
var constraints: PackedStringArray = [
	"You have limited time",
	"You have limited actions",
	"You have limited uses",
	"You cannot stop moving",
	"You can only move in one direction",
	"You can only act at certain times",
	"You can only hold one object",
	"You cannot repeat the same action",
	"Every action costs a resource",
	"Every action creates danger",
	"Every action affects something else",
	"Using the ability also hurts you",
	"Using the ability moves you",
	"Using the ability changes the environment",
	"The space gradually shrinks",
	"The environment constantly changes",
	"The environment reacts to your actions",
	"Previously safe areas become dangerous",
	"You cannot return to previous areas",
	"You cannot directly control your movement",
	"You must alternate between two states",
	"You can only affect nearby objects",
	"You can only affect distant objects",
	"You cannot see everything",
	"You only have partial information",
	"Enemies act whenever you act",
	"Enemies copy your actions",
	"Objects keep their momentum",
	"Actions cannot be undone",
	"You must sacrifice something to progress",
]
var goals: PackedStringArray = [
	"Reach the exit",
	"Survive for a set amount of time",
	"Collect everything",
	"Collect a required number of objects",
	"Defeat all enemies",
	"Defeat a specific enemy",
	"Protect something",
	"Escort something to safety",
	"Deliver an object",
	"Bring multiple objects together",
	"Separate objects",
	"Arrange objects correctly",
	"Activate all targets",
	"Deactivate all targets",
	"Capture an objective",
	"Escape a pursuing threat",
	"Prevent something from reaching you",
	"Keep a resource above zero",
	"Fill a meter",
	"Empty a meter",
	"Reach a target score",
	"Complete the objective in as few moves as possible",
	"Keep something alive",
	"Repair something",
	"Build something",
]
var pressures: PackedStringArray = [
	"Time is running out",
	"Enemies are constantly approaching",
	"Enemies become stronger over time",
	"More enemies appear over time",
	"The playable area is shrinking",
	"Safe areas are disappearing",
	"The environment is becoming more dangerous",
	"A hazard is steadily spreading",
	"A resource is constantly draining",
	"Health is slowly decreasing",
	"The objective is moving away",
	"The objective is becoming harder to reach",
	"Something must be protected from damage",
	"Something must be protected from reaching zero",
	"A pursuing threat cannot be stopped",
	"Mistakes make future actions harder",
	"Each action increases danger",
	"Each action attracts enemies",
	"Each action makes the environment less stable",
	"Waiting makes the situation worse",
	"Moving too quickly creates additional risk",
	"Staying still creates additional risk",
	"Resources become scarcer over time",
	"Useful areas become inaccessible",
	"Previous choices close off future options",
	"An opponent is competing for the same objective",
	"An opponent is actively undoing your progress",
	"The player must keep moving forward",
	"The player must maintain momentum",
	"The player must balance multiple urgent objectives",
]
var container_pretext: Dictionary[String, String] = {
	VERB: "The player must",
	CONSTRAINT: "while",
	GOAL: "in order to",
	PRESSURE: "as",
}
var container_button_pressed: Dictionary[String, Button] = {}


func _ready() -> void:
	DebugLog.set_enabled(debug_log_enabled)
	DebugLog.set_level(debug_log_level)

	if container_button == null:
		var err_msg: String = "Container Button is empty."
		DebugLog.log_error(self, err_msg)
		push_error(err_msg)
		return

	verb_check.pressed.connect(_on_verb_check_pressed)
	constraint_check.pressed.connect(_on_constraint_check_pressed)
	pressure_check.pressed.connect(_on_pressure_check_pressed)
	goal_check.pressed.connect(_on_goal_check_pressed)

	decision_edit.text_changed.connect(_check_export_button)

	randomize_button.pressed.connect(_on_randomize_pressed)
	export_button.pressed.connect(_on_export_pressed)
	export_button.disabled = true

	_populate_containers()


func _on_verb_check_pressed() -> void:
	for button in verb_container.get_children():
		button = button as Button
		button.disabled = verb_check.button_pressed


func _on_constraint_check_pressed() -> void:
	for button in constraint_container.get_children():
		button = button as Button
		button.disabled = constraint_check.button_pressed


func _on_pressure_check_pressed() -> void:
	for button in pressure_container.get_children():
		button = button as Button
		button.disabled = pressure_check.button_pressed


func _on_goal_check_pressed() -> void:
	for button in goal_container.get_children():
		button = button as Button
		button.disabled = goal_check.button_pressed


func _on_randomize_pressed() -> void:
	DebugLog.log_debug(self, "Randomize button pressed.")

	if not verb_check.button_pressed:
		_on_verb_selected(_pick_random_button(verb_container))
	if not constraint_check.button_pressed:
		_on_constraint_selected(_pick_random_button(constraint_container))
	if not goal_check.button_pressed:
		_on_goal_selected(_pick_random_button(goal_container))
	if not pressure_check.button_pressed:
		_on_pressure_selected(_pick_random_button(pressure_container))


func _pick_random_button(container: Container) -> Button:
	var buttons := container.get_children()
	return buttons.pick_random()


func _check_export_button() -> void:
	export_button.disabled = not (
		container_button_pressed.has_all([VERB, CONSTRAINT, GOAL, PRESSURE])
		and decision_edit.text != ""
	)


func _on_export_pressed() -> void:
	DebugLog.log_debug(self, "Export button pressed.")

	var file_dialog := FileDialog.new()
	file_dialog.file_mode = FileDialog.FILE_MODE_SAVE_FILE
	file_dialog.access = FileDialog.ACCESS_FILESYSTEM
	file_dialog.filters = PackedStringArray(["*.json ; JSON Files"])
	file_dialog.file_selected.connect(_on_export_file_selected)
	add_child(file_dialog)
	file_dialog.popup_centered()


func _on_export_file_selected(path: String) -> void:
	var data := {
		"verb": verb_label.text,
		"constraint": constraint_label.text,
		"pressure": pressure_label.text,
		"goal": goal_label.text,
		"decision": decision_edit.text,
	}

	var json_text := JSON.stringify(data, "\t")

	if not path.ends_with(".json"):
		path += ".json"

	var file := FileAccess.open(path, FileAccess.WRITE)
	if file:
		file.store_string(json_text)


func _populate_containers() -> void:
	# Populate verbs
	_populate_container(verb_container, verbs, _on_verb_selected)

	# Populate constraints
	_populate_container(
		constraint_container, constraints, _on_constraint_selected
	)

	# Populate goals
	_populate_container(goal_container, goals, _on_goal_selected)

	# Populate pressures
	_populate_container(
		pressure_container, pressures, _on_pressure_selected
	)


func _populate_container(
	parent_container: Container,
	button_texts: PackedStringArray,
	pressed_function: Callable
) -> void:
	for text in button_texts:
		var new_button := container_button.instantiate() as Button
		new_button.text = text
		new_button.pressed.connect(pressed_function.bind(new_button))
		parent_container.add_child(new_button)


func _on_selected(
	container_name: String, container_label: Label, button_pressed: Button
) -> void:
	if button_pressed == null:
		var err_msg: String = "button_pressed is null"
		DebugLog.log_error(self, err_msg)
		push_error(err_msg)
		return

	DebugLog.log_info(
		self, "%s selected: '%s'" % [
			container_name.capitalize(), button_pressed.text
		]
	)

	var button: Button = container_button_pressed.get(container_name)
	if button != null:
		button.button_pressed = false
	container_button_pressed[container_name] = button_pressed
	button_pressed.button_pressed = true

	container_label.text = (
		"%s %s" % [
			container_pretext[container_name], button_pressed.text.to_lower()
		]
	)

	_check_export_button()


func _on_verb_selected(button_pressed: Button) -> void:
	_on_selected(VERB, verb_label, button_pressed)


func _on_constraint_selected(button_pressed: Button) -> void:
	_on_selected(CONSTRAINT, constraint_label, button_pressed)


func _on_goal_selected(button_pressed: Button) -> void:
	_on_selected(GOAL, goal_label, button_pressed)


func _on_pressure_selected(button_pressed: Button) -> void:
	_on_selected(PRESSURE, pressure_label, button_pressed)
