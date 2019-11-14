shader_type canvas_item;

uniform vec4 color : hint_color;
uniform sampler2D noise_texture: hint_albedo;
uniform float scroll_speed: hint_range(-10.0, 10.0, 0.1);//how fast it will scroll; (+) to right, (-) to left
uniform float flash_interval: hint_range(0.0, 10.0, 1.0);

float remap_value(float v, float input_min, float input_max, float output_min, float output_max) {
	v = clamp(v, input_min, input_max);//clamp the value to be between the input expected min/max
	return output_min + (v - input_min) * (output_max - output_min)/(input_max - input_min); //basic remapping
}

void fragment() {
	vec4 tex = texture(TEXTURE, UV);
	vec2 coord = SCREEN_UV;
	
	vec4 noise = texture(noise_texture, vec2(coord.x - TIME * scroll_speed, coord.y));
	float intensity = remap_value(cos(TIME * flash_interval), -1.0, 1.0, 0.5, 0.9); //-1.0 and 1.0 are cos min/max

	float flash = tex.a * (noise.r + intensity);//noise rgb all the same(grayscale noise image) so just grab red
	
	COLOR = vec4(color.rgb, flash);

}