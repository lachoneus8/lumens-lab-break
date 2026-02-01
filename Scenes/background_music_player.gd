extends AudioStreamPlayer

@onready var song1 = preload("res://Audio/Music/8bit_town01_dry_moody.ogg")
@onready var song2 = preload("res://Audio/Music/8bit_town02_dry_moody.ogg")
@onready var song3 = preload("res://Audio/Music/8bit_town03_dry_moody.ogg")

var song_index = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	randomize()
	song_index = randi_range(1,3)
	self.play_next_song()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func play_next_song():
	if song_index == 1:
		self.stream = song2
	elif song_index == 2:
		self.stream = song3
	else:
		self.stream = song1
	song_index += 1
	self.play()
		
func _on_background_music_player_finished():
	# Function executes when song ends
	self.play_next_song()
