// C# Unity Script Example
// Language ID: 111

using System;
using System.Collections.Generic;

public class PlayerController
{
    // Properties
    public string PlayerName { get; set; }
    public int Health { get; set; }
    public float Speed { get; set; }
    
    // Constructor
    public PlayerController(string name)
    {
        PlayerName = name;
        Health = 100;
        Speed = 5.0f;
    }
    
    // Methods
    public void TakeDamage(int damage)
    {
        Health -= damage;
        Console.WriteLine($"{PlayerName} took {damage} damage. Health: {Health}");
    }
    
    public void Heal(int amount)
    {
        Health += amount;
        Console.WriteLine($"{PlayerName} healed {amount} HP. Health: {Health}");
    }
}

public class GameManager
{
    public static void Main()
    {
        Console.WriteLine("Hello from Unity C#!");
        
        // Create player
        var player = new PlayerController("Hero");
        Console.WriteLine($"Player created: {player.PlayerName}");
        
        // Simulate gameplay
        player.TakeDamage(25);
        player.Heal(15);
        
        // List example
        var inventory = new List<string> { "Sword", "Shield", "Potion" };
        Console.WriteLine("\nInventory:");
        foreach (var item in inventory)
        {
            Console.WriteLine($"  - {item}");
        }
        
        // Dictionary example
        var stats = new Dictionary<string, int>
        {
            { "Strength", 10 },
            { "Defense", 8 },
            { "Speed", 12 }
        };
        
        Console.WriteLine("\nPlayer Stats:");
        foreach (var stat in stats)
        {
            Console.WriteLine($"  {stat.Key}: {stat.Value}");
        }
    }
}
