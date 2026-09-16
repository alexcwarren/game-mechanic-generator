extends TextEdit

@export var tooltip_font_size: int = 12


func _make_custom_tooltip(_for_text: String) -> Object:
	var panel := PanelContainer.new()
	panel.custom_minimum_size.x = 400.0

	var margin := MarginContainer.new()
	margin.add_theme_constant_override("margin_left", 16)
	margin.add_theme_constant_override("margin_right", 16)
	margin.add_theme_constant_override("margin_top", 14)
	margin.add_theme_constant_override("margin_bottom", 14)

	var content := VBoxContainer.new()
	content.add_theme_constant_override("separation", 8)

	var title := Label.new()
	title.text = "Decision / Tension"
	title.add_theme_font_size_override("font_size", tooltip_font_size)

	var description := Label.new()
	description.text = (
		"Describe the meaningful choice or tension created by "
		+ "the selected Verb, Constraint, and Goal."
	)
	description.add_theme_font_size_override("font_size", tooltip_font_size)
	description.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART

	var question := Label.new()
	question.text = "\"What does the player have to think about before acting?\""
	question.add_theme_font_size_override("font_size", tooltip_font_size)
	question.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART

	var examples := Label.new()
	examples.text = (
		"Examples:\n"
		+ "• When is it worth using my limited action?\n"
		+ "• Which route should I commit to?\n"
		+ "• Is this reward worth entering danger?\n"
		+ "• Which enemy should I deal with first?\n"
		+ "• Should I spend this resource now or save it?"
	)
	examples.add_theme_font_size_override("font_size", tooltip_font_size)
	examples.autowrap_mode = TextServer.AUTOWRAP_WORD_SMART

	content.add_child(title)
	content.add_child(description)
	content.add_child(question)
	content.add_child(examples)

	margin.add_child(content)
	panel.add_child(margin)

	return panel
