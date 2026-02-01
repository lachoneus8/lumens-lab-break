extends LightReactiveEntity

# Mouse moves ONLY when near light
func should_move() -> bool:
	return is_near_light
