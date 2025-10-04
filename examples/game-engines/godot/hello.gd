# GDScript Example (Godot)
# Language ID: 109

extends Node

# Variables
var player_name: String = "Player"
var health: int = 100
var position: Vector2 = Vector2(0, 0)

# Called when the node enters the scene tree
func _ready():
	print("Hello from GDScript (Godot 4.2)!")
	print("Player: ", player_name)
	print("Health: ", health)
	print("Position: ", position)
	
	# Call functions
	take_damage(20)
	heal(10)
	
	# Array operations
	var items = ["Sword", "Shield", "Potion"]
	print("\nInventory:")
	for item in items:
		print("  - ", item)
	
	# Dictionary (similar to objects)
	var stats = {
		"strength": 10,
		"defense": 8,
		"speed": 12
	}
	
	print("\nPlayer Stats:")
	for stat_name in stats:
		print("  ", stat_name, ": ", stats[stat_name])

# Function to reduce health
func take_damage(amount: int) -> void:
	health -= amount
	print("Took ", amount, " damage. Health: ", health)

# Function to restore health
func heal(amount: int) -> void:
	health += amount
	print("Healed ", amount, " HP. Health: ", health)

# Calculate distance between two points
func distance_to(other_pos: Vector2) -> float:
	return position.distance_to(other_pos)
