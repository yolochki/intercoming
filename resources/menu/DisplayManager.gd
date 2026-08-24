# DisplayManager.gd
extends Node

var current_digits: String = ""
const MAX_DIGITS = 6
const PREFIX = "КВАРТИРА: "

# Ссылка на дисплей (будет установлена из сцены)
var display_label: Label = null

func _ready() -> void:
	# Автоматически найдём дисплей при старте
	call_deferred("_find_display")

func _find_display() -> void:
	# Ищем дисплей в сцене по пути
	var root = get_tree().current_scene
	if root:
		var node = root.get_node_or_null("Node2D/display/text")
		if node is Label:
			display_label = node
			print("[DisplayManager] Дисплей найден!")

func add_digit(digit: String) -> void:
	if current_digits.length() < MAX_DIGITS:
		current_digits += digit
		_update_display()

func clear_digits() -> void:
	current_digits = ""
	_update_display()

func _update_display() -> void:
	if display_label:
		var text = PREFIX + current_digits
		if current_digits.length() < MAX_DIGITS:
			text += "_"
		display_label.text = text
	else:
		# Если дисплей не найден — пытаемся найти снова
		_find_display()
