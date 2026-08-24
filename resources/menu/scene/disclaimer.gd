extends Label

const disclaimers = {
	"en": [
		"INTERCOMING is a non-profitable game with an open-source license GPLv3.\nPlease be concerned about seeing paid versions of INTERCOMING.\nTHIS IS A SCAM!"
	],
	"ru": [
		"INTERCOMING — это некоммерческая игра с открытым исходным кодом (GPLv3).\nЕсли вы видите платные версии INTERCOMING — это МОШЕННИЧЕСТВО!"
	],
	"ua": [
		"INTERCOMING — це некомерційна гра з відкритим кодом (GPLv3).\nЯкщо ви бачите платні версії INTERCOMING — це ШАХРАЙСТВО!"
	],
	"de": [
		"INTERCOMING ist ein nicht-kommerzielles Spiel mit Open-Source-Lizenz GPLv3.\nWenn Sie kostenpflichtige Versionen von INTERCOMING sehen, ist das BETRUG!"
	],
	"fr": [
		"INTERCOMING est un jeu non lucratif avec une licence open-source GPLv3.\nSi vous voyez des versions payantes d'INTERCOMING, c'est une ARNAQUE!"
	]
}

var languages = ["en", "ru", "ua", "de", "fr"]
var current_lang_index = 0
var timer: Timer

func _ready() -> void:
	# Включаем перенос слов
	autowrap_mode = TextServer.AUTOWRAP_WORD_SMART
	# Если не знаешь какое количество строк — просто убери это:
	# max_lines = 0  # ЭТА СТРОКА ВЫЗЫВАЕТ ОШИБКУ
	
	update_text()
	
	timer = Timer.new()
	timer.wait_time = 5.0
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _on_timer_timeout() -> void:
	current_lang_index = (current_lang_index + 1) % languages.size()
	update_text()

func update_text() -> void:
	var lang = languages[current_lang_index]
	var texts = disclaimers[lang]
	text = texts[0]
	print("[Disclaimer] Язык: ", lang)
