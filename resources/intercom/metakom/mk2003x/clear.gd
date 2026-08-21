extends Button

@export var sound_path: String = "res://resources/intercom/metakom/mk2003x/init.mp3"
@onready var display: Label = get_node("../display/text")

func _ready() -> void:
	pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	# Очищаем дисплей
	if display:
		display.text = ""
	
	# Звук
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
	
	# Анимация нажатия
	var tween = create_tween()
	tween.tween_property(self, "scale", Vector2(0.9, 0.9), 0.08)
	tween.tween_property(self, "scale", Vector2(1, 1), 0.08)
