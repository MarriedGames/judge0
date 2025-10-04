// C++ Unreal Engine Example
// Language ID: 113

#include <iostream>
#include <string>
#include <vector>
#include <memory>

// Simple Actor class (simulating Unreal Engine)
class Actor {
protected:
    std::string name;
    float health;
    
public:
    Actor(const std::string& n) : name(n), health(100.0f) {
        std::cout << "Actor created: " << name << std::endl;
    }
    
    virtual ~Actor() = default;
    
    virtual void BeginPlay() {
        std::cout << name << " begins play!" << std::endl;
    }
    
    void TakeDamage(float damage) {
        health -= damage;
        std::cout << name << " took " << damage << " damage. Health: " << health << std::endl;
    }
    
    float GetHealth() const { return health; }
    std::string GetName() const { return name; }
};

// Player Character class
class PlayerCharacter : public Actor {
private:
    int score;
    
public:
    PlayerCharacter(const std::string& n) : Actor(n), score(0) {}
    
    void BeginPlay() override {
        std::cout << "Player Character " << name << " is ready!" << std::endl;
    }
    
    void AddScore(int points) {
        score += points;
        std::cout << "Score added! Current score: " << score << std::endl;
    }
    
    int GetScore() const { return score; }
};

int main() {
    std::cout << "Hello from Unreal Engine C++!" << std::endl;
    std::cout << "================================" << std::endl;
    
    // Create player
    auto player = std::make_unique<PlayerCharacter>("Hero");
    player->BeginPlay();
    
    // Simulate gameplay
    player->AddScore(100);
    player->TakeDamage(25.0f);
    player->AddScore(50);
    
    // Array example
    std::vector<std::string> inventory = {"Sword", "Shield", "Health Potion"};
    std::cout << "\nInventory:" << std::endl;
    for (const auto& item : inventory) {
        std::cout << "  - " << item << std::endl;
    }
    
    std::cout << "\nFinal Stats:" << std::endl;
    std::cout << "  Name: " << player->GetName() << std::endl;
    std::cout << "  Health: " << player->GetHealth() << std::endl;
    std::cout << "  Score: " << player->GetScore() << std::endl;
    
    return 0;
}
