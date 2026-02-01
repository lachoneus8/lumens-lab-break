extends LightReactiveEntity

# Statue moves ONLY when far from light
func should_move() -> bool:
	return not is_near_light
