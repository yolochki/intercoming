extends Label

const MAX_DIGITS = 4

func add_digit(digit: String) -> void:
	if text.length() < MAX_DIGITS:
		text += digit
	else:
		push_warning("[Display] Достигнут лимит символов!")

func clear_display() -> void:
	text = ""

func get_code() -> String:
	return text
