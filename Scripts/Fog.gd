extends Node2D

const LightTexture = preload("res://Textures/Light.png")
const GRID_SIZE = 16

@onready var fog = $Fog

var display_size: Vector2
var display_width: float
var display_height: float

var fogImage = Image.new()
var fogTexture = ImageTexture.new()
var lightImage = LightTexture.get_image()
var light_offset = Vector2(LightTexture.get_width() / 2.0, LightTexture.get_height() / 2.0)

var fog_image_width: float
var fog_image_height: float

func _ready():
	# Initialize viewport dimensions
	display_size = get_viewport_rect().size
	display_width = display_size.x
	display_height = display_size.y + 50

	#fog_image_width = display_width / GRID_SIZE
	#fog_image_height = display_height / GRID_SIZE
	fog_image_width = display_width / GRID_SIZE
	fog_image_height = display_height / GRID_SIZE

	fogImage = Image.create(fog_image_width, fog_image_height, false, Image.FORMAT_RGBAH)
	fogImage.fill(Color.BLACK)
	lightImage.convert(Image.FORMAT_RGBAH)
	
	# Reduce alpha of light image
	# adjust_image_alpha(lightImage, 0.5) # 0.5 = 50% opacity, adjust as needed
	
	fog.scale *= GRID_SIZE
	
	# Center the fog texture on the screen
	fog.position = display_size / 2
	fog.centered = true

func adjust_image_alpha(image: Image, alpha_multiplier: float):
	for y in range(image.get_height()):
		for x in range(image.get_width()):
			var color = image.get_pixel(x, y)
			color.a *= alpha_multiplier
			image.set_pixel(x, y, color)

func update_fog():
	# Reset fog to black
	fogImage.fill(Color.BLACK)
	
	# Get all lights in the scene
	var lights = get_tree().get_nodes_in_group("lights")
	
	var light_rect = Rect2(Vector2.ZERO, Vector2(lightImage.get_width(), lightImage.get_height()))
	
	# Render a light image for each light
	for light in lights:
		if light is Node2D:
			# Convert light's global position to fog grid position
			var light_grid_position = light.global_position / GRID_SIZE
			# Blend the light image at the light's position
			fogImage.blend_rect(lightImage, light_rect, light_grid_position - light_offset)
	
	update_fog_image_texture()

func update_fog_image_texture():
	fogTexture = ImageTexture.create_from_image(fogImage)
	fog.texture = fogTexture

func _process(_delta):
	update_fog()
