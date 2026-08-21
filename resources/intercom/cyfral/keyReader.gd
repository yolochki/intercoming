extends Button

@export var sound_path: String = "res://resources/intercom/cyfral/ccd40/error.mp3"
@onready var display: Label = get_node("../display/text")
func _ready() -> void:
	pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	# 1. ПОКАЗЫВАЕМ "Err" на дисплее
	display.text = "Err"
	
	# 2. ЗАПУСКАЕМ ЗВУК (в фоновом режиме)
	_play_sound()
	
	# 3. АНИМАЦИЯ НАЖАТИЯ (тоже параллельно)
	_animate_button()
	
	# 4. ЧЕРЕЗ 0.5 СЕКУНДЫ ОЧИЩАЕМ ДИСПЛЕЙ
	await get_tree().create_timer(0.3).timeout
	display.text = "----"
	await get_tree().create_timer(0.2).timeout
	display.text = ""

# ОТДЕЛЬНАЯ ФУНКЦИЯ ДЛЯ ЗВУКА
func _play_sound() -> void:
	var sound: AudioStream = load(sound_path)
	if sound == null:
		push_error("[Button] ЗВУК НЕ НАЙДЕН: ", sound_path)
		return
	
	var player = AudioStreamPlayer.new()
	player.stream = sound
	add_child(player)
	player.play()
	await player.finished
	player.queue_free()

# ОТДЕЛЬНАЯ ФУНКЦИЯ ДЛЯ АНИМАЦИИ
func _animate_button() -> void:
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.9, 0.9), 0.08)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.08)
