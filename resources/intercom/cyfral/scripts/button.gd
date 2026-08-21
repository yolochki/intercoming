extends Button

@export var sound_path: String = "res://resources/intercom/cyfral/ccd40/button.mp3"
@export var error_sound_path: String = "res://resources/intercom/cyfral/ccd40/error.mp3"
@export var digit: String = "1"
@onready var display: Label = get_node("../display/text")
@onready var display_parent: ColorRect = get_node("../display")

const MAX_DIGITS = 4

func _ready() -> void:
	pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	if display.text.length() >= MAX_DIGITS:
		# Ошибка! Лимит превышен
		_show_error()
		return
	
	# Всё хорошо — добавляем цифру
	display.text += digit
	_play_sound(sound_path)
	_animate_button()

func _show_error() -> void:
	# Показываем ошибку на дисплее
	display.text = "Err"
	
	# Играем звук ОШИБКИ!
	_play_sound(error_sound_path)
	
	# Через 0.3 сек показываем "----"
	await get_tree().create_timer(0.3).timeout
	display.text = "----"
	
	# Через 0.2 сек очищаем
	await get_tree().create_timer(0.2).timeout
	display.text = ""

func _play_sound(path: String) -> void:
	var sound: AudioStream = load(path)
	if sound == null:
		push_error("[Button] ЗВУК НЕ НАЙДЕН: ", path)
		return
	
	var player = AudioStreamPlayer.new()
	player.stream = sound
	add_child(player)
	player.play()
	await player.finished
	player.queue_free()

func _animate_button() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.9, 0.9), 0.08)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.08)
