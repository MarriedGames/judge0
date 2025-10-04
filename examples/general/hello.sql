-- SQL Example with SQLite
-- Language ID: 108

-- Create tables
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY,
    username TEXT NOT NULL,
    email TEXT,
    created_at TEXT DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS posts (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    title TEXT,
    content TEXT,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Insert data
INSERT INTO users (username, email) VALUES 
    ('john_doe', 'john@example.com'),
    ('jane_smith', 'jane@example.com'),
    ('bob_wilson', 'bob@example.com');

INSERT INTO posts (user_id, title, content) VALUES 
    (1, 'First Post', 'Hello World!'),
    (1, 'Second Post', 'Learning SQL'),
    (2, 'Jane''s Post', 'SQL is awesome!');

-- Query data
SELECT 'Users:' AS category;
SELECT id, username, email FROM users;

SELECT '' AS separator;

SELECT 'Posts with Authors:' AS category;
SELECT 
    p.title,
    p.content,
    u.username AS author
FROM posts p
JOIN users u ON p.user_id = u.id
ORDER BY p.id;

-- Aggregate example
SELECT '' AS separator;
SELECT 'Post Count by User:' AS category;
SELECT 
    u.username,
    COUNT(p.id) AS post_count
FROM users u
LEFT JOIN posts p ON u.id = p.user_id
GROUP BY u.username;
