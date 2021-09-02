extends Node

# * Attributes *
# Options Menu -> Music
var enable_music = true
var player_node

export var emeralds = 0
export var diamonds = 0
export var rubys = 0
export var amethysts = 0
export var sapphires = 0

var money = 0
var inShop = false
onready var world = get_node("../World")
onready var terrain = get_node("../World/destructable")
var active_gun_rate = 5
var currentWeapon = "Gun"
var purchases = {
	"Drill":false,
	"SpecialBoots":false,
	"Jetpack":false,
	"AssaultRifle":false,
	"MachineGun":false,
	"Shotgun":false
}

var upgrades = {
	"Boots": 1,
	"Gun": 1,
	"Hat": 1
}
