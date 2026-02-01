extends LightReactiveEntity

@onready var notice_light = preload("res://Audio/statue_notice_light_filmcow.wav")

# Statue moves ONLY when far from light
func should_move() -> bool:
	return not is_near_light
	
func update_sound_player_stream():
	sound_player.stream = notice_light
