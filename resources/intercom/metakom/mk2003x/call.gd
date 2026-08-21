extends Button

@export var sound_path: String = "res://resources/intercom/metakom/mk2003x/calling.mp3"
@export var error_sound_path: String = "res://resources/intercom/metakom/mk2003x/error.mp3"
@onready var display: Label = get_node("../display/text")
@onready var display_parent: ColorRect = get_node("../display")

func _ready() -> void:
	pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	# Проверяем, что на дисплее есть номер
	if display.text == "":
		# Пустой дисплей — показываем ошибку
		_show_error("-t-", "EMPTY")
		return
	
	# Проверяем, что номер — это число
	var number = display.text.to_int()
	
	# Проверяем, что номер меньше или равен 999
	if number > 999:
		_show_error("Err", "HIGH")
		return
	
	# Если всё хорошо — звоним!
	_play_sound(sound_path)
	_animate_button()
	
	# Можно добавить статус "CALL" на дисплей
	
	# И очистить через 1.5 секунды
	await get_tree().create_timer(1.5).timeout
	display.text = ""

func _show_error(type: String, reason: String) -> void:
	# Играем звук ошибки
	_play_sound(error_sound_path)
	
	if type == "Err":
		display.text = "Err"
	
	await get_tree().create_timer(0.5).timeout
	display.text = "-t-"
	await get_tree().create_timer(0.2).timeout
	# Очищаем
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
