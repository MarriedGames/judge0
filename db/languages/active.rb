# Custom Languages Configuration for Judge0
# Customized for game development and web development

@languages ||= []
@languages +=
[
  # ============================================================
  # WEB DEVELOPMENT LANGUAGES
  # ============================================================
  
  {
    id: 100,
    name: "HTML/CSS/JavaScript",
    is_archived: false,
    source_file: "index.html",
    run_cmd: "/usr/local/node-22/bin/node /usr/local/bin/run-html.js index.html"
  },
  {
    id: 101,
    name: "JavaScript",
    is_archived: false,
    source_file: "script.js",
    run_cmd: "/usr/local/node-22/bin/node script.js"
  },
  {
    id: 102,
    name: "TypeScript",
    is_archived: false,
    source_file: "script.ts",
    compile_cmd: "/usr/local/node-22/bin/npx tsc %s script.ts --outDir .",
    run_cmd: "/usr/local/node-18/bin/node script.js"
  },
  {
    id: 103,
    name: "Vue 3 (Multi-file)",
    is_archived: false,
  },
  {
    id: 104,
    name: "Nuxt 4 ",
    is_archived: false,
  },
  
  # ============================================================
  # GENERAL PURPOSE LANGUAGES
  # ============================================================
  
  {
    id: 105,
    name: "Python",
    is_archived: false,
    source_file: "script.py",
    run_cmd: "/usr/local/python-3.13/bin/python3 script.py"
  },
  {
    id: 106,
    name: "Bash",
    is_archived: false,
    source_file: "script.sh",
    run_cmd: "/bin/bash script.sh"
  },
  {
    id: 107,
    name: "Lua",
    is_archived: false,
    source_file: "script.lua",
    run_cmd: "/usr/local/lua-5.4/bin/lua script.lua"
  },
  
  # ============================================================
  # DATABASE
  # ============================================================
  
  {
    id: 108,
    name: "SQL",
    is_archived: false,
    source_file: "script.sql",
    run_cmd: "/usr/bin/sqlite3 :memory: < script.sql"
  },
  
  # ============================================================
  # GODOT ENGINE (GDScript & Shaders)
  # ============================================================
  
  {
    id: 109,
    name: "GDScript (Godot 4.5)",
    is_archived: false,
    source_file: "script.gd",
    run_cmd: "/usr/local/godot-4.5/godot --headless --script script.gd"
  },
  {
    id: 110,
    name: "Godot Shader Language (GLSL)",
    is_archived: false,
    source_file: "shader.gdshader",
    run_cmd: "/usr/local/godot-4.5/godot --headless --check-only shader.gdshader"
  },
  
  # ============================================================
  # UNITY ENGINE (C#)
  # ============================================================
  
  {
    id: 111,
    name: "C# (Unity)",
    is_archived: false,
    source_file: "Script.cs",
    compile_cmd: "/usr/local/mono-6.12/bin/mcs -r:/usr/local/unity-libs/UnityEngine.dll %s Script.cs",
    run_cmd: "/usr/local/mono-6.12/bin/mono Script.exe"
  },
  
  # ============================================================
  # UNREAL ENGINE (C++)
  # ============================================================
  
  {
    id: 113,
    name: "C++ (Unreal Engine)",
    is_archived: false,
    source_file: "main.cpp",
    compile_cmd: "/usr/bin/g++-11 -std=c++17 -I/usr/local/unreal-headers %s main.cpp -o main",
    run_cmd: "./main"
  },
  {
    id: 114,
    name: "Blueprints Visual Scripting (Unreal Engine)",
    is_archived: false,
    source_file: "blueprint.json",
    run_cmd: "/usr/local/node-18/bin/node /usr/local/bin/blueprint-interpreter.js blueprint.json"
  },
  
  # ============================================================
  # GAMEMAKER (GML)
  # ============================================================
  
  {
    id: 115,
    name: "GML (GameMaker Language)",
    is_archived: false,
    source_file: "script.gml",
    run_cmd: "/usr/local/bin/gml-runner script.gml"
  },
  
  # ============================================================
  # DOCKER & CONTAINERS
  # ============================================================
  
  {
    id: 116,
    name: "Dockerfile",
    is_archived: false,
    source_file: "Dockerfile",
    run_cmd: "/usr/bin/docker build -t test-image -f Dockerfile . && echo 'Dockerfile valid'"
  },
  {
    id: 117,
    name: "Docker Compose (YAML)",
    is_archived: false,
    source_file: "docker-compose.yml",
    run_cmd: "/usr/local/bin/docker-compose -f docker-compose.yml config"
  },
  
  # ============================================================
  # MULTI-FILE PROGRAM SUPPORT
  # ============================================================
  
  {
    id: 118,
    name: "Multi-file program",
    is_archived: false,
  }
]