extends Button

@export var sound_path: String = "res://resources/intercom/metakom/mk2003x/button.mp3"
@export var error_sound_path: String = "res://resources/intercom/metakom/mk2003x/error.mp3"
@export var digit: String = "1"
@onready var display: Label = get_node("../display/text")

const MAX_DIGITS = 3
var _is_processing: bool = false  # ← БЛОКИРОВКА!

func _ready() -> void:
	pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	if _is_processing:
		return  # Игнорируем повторные нажатия
	
	if display.text.length() >= MAX_DIGITS:
		_show_error()
		return
	
	display.text += digit
	_play_sound(sound_path)
	_animate_button()

func _show_error() -> void:
	_is_processing = true
	display.text = "Err"
	_play_sound(error_sound_path)
	
	await get_tree().create_timer(1).timeout
	display.text = "-t-"
	
	await get_tree().create_timer(0.2).timeout
	display.text = ""
	
	_is_processing = false

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
