extends Camera3D

@export var auto_rotate_speed: float = 10.0
@export var max_angle: float = 10

func _process(delta: float) -> void:
	# Автоматическое вращение с ограничением
	var angle = sin(Time.get_ticks_msec() * 0.001 * auto_rotate_speed) * max_angle
	rotation_degrees.y = angle
	rotation_degrees.x = sin(Time.get_ticks_msec() * 0.001 * auto_rotate_speed * 0.5) * 1
