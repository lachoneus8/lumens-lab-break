extends CharacterBody2D

@export var speed: float = 300.0
@export var pickupRange: float = 40
@onready var item_hold_pos = $ItemHoldPos

var item_stack: Array[Node2D] = []

func _physics_process(delta: float) -> void:
	# Get input direction
	var input_vector = Vector2.ZERO
	
	if Input.is_action_pressed("Move Right"):
		input_vector.x += 1
	if Input.is_action_pressed("Move Left"):
		input_vector.x -= 1
	if Input.is_action_pressed("Move Down"):
		input_vector.y += 1
	if Input.is_action_pressed("Move Up"):
		input_vector.y -= 1
	
	# Normalize the input vector to prevent faster diagonal movement
	input_vector = input_vector.normalized()
	
	# Set velocity
	velocity = input_vector * speed * delta
	
	# Move the character
	move_and_slide()
	
	if Input.is_action_just_pressed("Pickup"):
		pickup_item()

	if Input.is_action_just_pressed("Drop"):
		drop_item()

func pickup_item():
	# Find all items in the scene
	var items = get_tree().get_nodes_in_group("items")
	
	print("Pickup pressed! Found ", items.size(), " items in 'items' group")
	
	var nearest_item: Node2D = null
	var nearest_distance: float = pickupRange
	
	# Find the nearest item within range
	for item in items:
		if item is Node2D:
			var distance = global_position.distance_to(item.global_position)
			print("Item at distance: ", distance, " (range: ", pickupRange, ")")
			if distance < nearest_distance:
				nearest_distance = distance
				nearest_item = item
	
	# If an item was found, pick it up
	if nearest_item:
		print("Picking up item!")
		# Remove from items group
		nearest_item.remove_from_group("items")
		
		# Reparent to ItemHoldPos
		var old_parent = nearest_item.get_parent()
		old_parent.remove_child(nearest_item)
		item_hold_pos.add_child(nearest_item)
		
		# Reset transform relative to ItemHoldPos
		nearest_item.position = Vector2.ZERO
		nearest_item.rotation = 0
		
		# Add to stack (FILO - First In Last Out)
		item_stack.push_back(nearest_item)

func drop_item():
	if item_stack.size() == 0:
		print("No items to drop!")
		return
	
	var item_to_drop = item_stack.pop_back()
	print("Dropping item!")

	# Reparent to the main scene (assuming it's the root)
	var root = get_tree().get_root().get_child(0)
	item_hold_pos.remove_child(item_to_drop)
	root.add_child(item_to_drop)
	# Set the item's global position to the player's position
	item_to_drop.global_position = global_position + Vector2(30, 30)

	item_to_drop.add_to_group("items")
