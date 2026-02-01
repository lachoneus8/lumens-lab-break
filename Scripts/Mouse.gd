extends LightReactiveEntity

@onready var notice_light = preload("res://Audio/mouse_notice_light_filmcow.wav")

# Mouse moves ONLY when near light
func should_move() -> bool:
	return is_near_light

func update_sound_player_stream():
	sound_player.stream = notice_light
