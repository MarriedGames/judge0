// Godot Shader Language Example
// Language ID: 110

shader_type canvas_item;

// Uniforms (parameters)
uniform vec4 color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float intensity : hint_range(0.0, 2.0) = 1.0;
uniform sampler2D noise_texture;

// Fragment shader
void fragment() {
	// Get the current UV coordinate
	vec2 uv = UV;
	
	// Sample the texture
	vec4 tex_color = texture(TEXTURE, uv);
	
	// Apply color tint
	vec4 tinted = tex_color * color * intensity;
	
	// Output final color
	COLOR = tinted;
}

// Vertex shader (optional)
void vertex() {
	// Simple wave effect
	VERTEX.y += sin(TIME + VERTEX.x * 0.1) * 2.0;
}
