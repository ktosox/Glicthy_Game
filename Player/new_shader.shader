shader_type canvas_item;
render_mode blend_mix;

uniform vec2 offset = vec2(0.0, 0.0);
uniform vec4 modulateA : hint_color;
uniform vec4 modulateB : hint_color;

void fragment() {
	vec2 ps = TEXTURE_PIXEL_SIZE;

	vec4 shadowA = vec4(modulateA.rgb, texture(TEXTURE, UV - offset * ps).a * modulateA.a);
	vec4 shadowB = vec4(modulateB.rgb, texture(TEXTURE, UV + offset * ps).a * modulateB.a);
	vec4 shadow = shadowA - shadowB;
	vec4 col = texture(TEXTURE, UV);
	


	COLOR = mix(shadow, col, col.a);

}