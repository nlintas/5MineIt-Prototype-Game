extends MarginContainer

# * Attributes *
onready var title_screen_scene = load("res://TitleScreen/TitleScreen.tscn")
onready var title_screen_selector = $CenterContainer/VBoxContainer/CenterContainer2/VBoxContainer/CenterContainer2/HBoxContainer/TitleScreenSelector

var current_selection = 0

# Audio Players
var audioPlayer = AudioStreamPlayer.new()
var buttonAudioPlayer = AudioStreamPlayer.new()

func _ready():
	# Audio Player Initialisation
	self.add_child(audioPlayer)
	self.add_child(buttonAudioPlayer)
	# Background Music
	audioPlayer.stream = load ('res://Music and Sounds/Background Music/The Story Continues.ogg')
	audioPlayer.play()
	
	set_current_selector(0)
	get_tree().paused = true

# * System Callback Methods *
func _process(_delta):
	
	if Input.is_action_just_pressed("ui_accept"):
		# Button Sound Effect
		buttonAudioPlayer.stream = load ('res://Music and Sounds/Menu Sound Effects/confirm_selection.ogg')
		buttonAudioPlayer.play()
		
		handle_selection(current_selection)
	elif Input.is_action_just_pressed("exit"):
		queue_free()
		get_tree().paused = false

# * Methods *
func set_current_selector(_current_selection):
	title_screen_selector.text=""
	
	if _current_selection == 0:
		title_screen_selector.text =">"
		
func handle_selection(_current_selection):
	
	if _current_selection == 0:
		get_tree().paused = false
		get_parent().get_parent().queue_free()
		get_tree().get_root().add_child(title_screen_scene.instance())
		queue_free()
		_reset_previous_data()

func switch_scenes():
	set_current_selector(current_selection)
	handle_selection(current_selection)

func _on_TitleScreenButton_pressed():
	# Button Sound Effect
	buttonAudioPlayer.stream = load ('res://Music and Sounds/Menu Sound Effects/confirm_selection.ogg')
	buttonAudioPlayer.play()
	
	current_selection = 0
	switch_scenes()

func _reset_previous_data():
	
	# Reset the money
	GlobalVariables.money = 0
	# Reset the shop
	GlobalVariables.inShop = false
	# Reset the purchases
	GlobalVariables.purchases = { "Drill":false, "SpecialBoots":false, 
	"Jetpack":false, "AssaultRifle":false, "MachineGun":false, "Shotgun":false }
	# Reset the Upgrades
	GlobalVariables.upgrades = { "Boots": 1, "Gun": 1, "Hat": 1 }
	# Reset the default weapon
	GlobalVariables.currentWeapon = "Gun"
