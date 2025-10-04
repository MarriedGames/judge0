/// GML (GameMaker Language) Example
/// Language ID: 115

// Create event
show_debug_message("Hello from GameMaker Language!");

// Variables
var player_name = "Hero";
var player_health = 100;
var player_x = 0;
var player_y = 0;

show_debug_message("Player: " + player_name);
show_debug_message("Health: " + string(player_health));

// Function example
function take_damage(amount) {
    player_health -= amount;
    show_debug_message("Took " + string(amount) + " damage. Health: " + string(player_health));
}

function heal(amount) {
    player_health += amount;
    show_debug_message("Healed " + string(amount) + " HP. Health: " + string(player_health));
}

// Simulate gameplay
take_damage(20);
heal(10);

// Array example
var inventory = ["Sword", "Shield", "Potion"];
show_debug_message("\nInventory:");
for (var i = 0; i < array_length(inventory); i++) {
    show_debug_message("  - " + inventory[i]);
}

// Struct example (GML 2.3+)
var player_stats = {
    strength: 10,
    defense: 8,
    speed: 12
};

show_debug_message("\nPlayer Stats:");
show_debug_message("  Strength: " + string(player_stats.strength));
show_debug_message("  Defense: " + string(player_stats.defense));
show_debug_message("  Speed: " + string(player_stats.speed));
