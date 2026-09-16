extends Node

@export var debug_log_enabled: bool = false
@export var debug_log_level: DebugLog.Level = DebugLog.Level.ERROR


func _ready() -> void:
	DebugLog.set_enabled(debug_log_enabled)
	DebugLog.set_level(debug_log_level)
