extends Button

const SOUND_PATH = "res://resources/menu/sounds/button_press.mp3"
const SCENE_PATH = "res://resources/intercom/vizit/bvd-431dxkcb/ic.tscn"

var _audio_player: AudioStreamPlayer = null

func _ready() -> void:
	# Создаём аудио-плеер, если его нет
	if _audio_player == null:
		_audio_player = AudioStreamPlayer.new()
		add_child(_audio_player)
	
	# Загружаем звук
	var sound = load(SOUND_PATH)
	if sound:
		_audio_player.stream = sound
	else:
		push_error("[Button] Не удалось загрузить звук: ", SOUND_PATH)
	
	# Подключаем сигнал нажатия
	pressed.connect(_on_button_pressed)

func _on_button_pressed() -> void:
	# Проигрываем звук
	if _audio_player and _audio_player.stream:
		_audio_player.play()
	
	# Ждём окончания звука или 0.3 секунды
	await get_tree().create_timer(0.3).timeout
	
	# Меняем сцену
	var err = get_tree().change_scene_to_file(SCENE_PATH)
	if err != OK:
		push_error("[Button] Ошибка смены сцены: ", err)
