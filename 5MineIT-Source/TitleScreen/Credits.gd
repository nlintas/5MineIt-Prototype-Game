extends MarginContainer

# * Attributes *
var title_scene = load("res://TitleScreen/TitleScreen.tscn")

# Audio Players
var audioPlayer = AudioStreamPlayer.new()
var buttonAudioPlayer = AudioStreamPlayer.new()

# * System Callback Methods *
func _ready():
	# Audio Player Initialisation
	self.add_child(audioPlayer)
	self.add_child(buttonAudioPlayer)
	# Background Music
	audioPlayer.stream = load ('res://Music and Sounds/Background Music/Purple Black Loop.ogg')
	audioPlayer.play()

func _process(_delta):
	if(Input.is_action_just_pressed("ui_accept")):
		# Button Sound Effect
		buttonAudioPlayer.stream = load ('res://Music and Sounds/Menu Sound Effects/confirm_selection.ogg')
		buttonAudioPlayer.play()
		
		get_parent().add_child(title_scene.instance())
		queue_free()
		
# * Methods *
func _on_Button_pressed():
		
	get_parent().add_child(title_scene.instance())
	queue_free()
