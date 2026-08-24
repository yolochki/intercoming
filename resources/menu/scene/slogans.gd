extends Label

const slogans = [
	"Здесь могла быть ваша реклама.",
	"Хули так мало!?",
	"Iosevka Charon Mono крутой шрифт",
	"Бля нахуя Я сюда зашёл...",
	"Что если Я добавлю в игру EAC...",
	"Как насчёт Denuvo?",
	"Подьезд тебя ждет!",
	"Че покупать эмулятор ключей или нет?",
	"Пошли по домофонам",
	"#999",
	"There can be your ads.",
	"WHY SO LITTLE!?",
	"Iosevka Charon Mono is a cool font.",
	"Why the fuck did I open this...",
	"What if I add Easy AntiCheat to the game...",
	"What 'bout Denuvo?",
	"The entrance waits!!",
	"Should I buy a key emulator?",
	"Let's go by the intercoms",
	"#999"
]

var current_index = 0
var timer: Timer

func _ready() -> void:
	# Устанавливаем первый слоган
	text = slogans[current_index]
	
	# Создаём таймер
	timer = Timer.new()
	timer.wait_time = 1
	timer.autostart = true
	timer.timeout.connect(_on_timer_timeout)
	add_child(timer)

func _on_timer_timeout() -> void:
	# Переключаемся на следующий слоган
	current_index = (current_index + 1) % slogans.size()
	text = slogans[current_index]
