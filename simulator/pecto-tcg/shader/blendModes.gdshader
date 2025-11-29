shader_type canvas_item;

uniform sampler2D SCREEN : hint_screen_texture;

uniform int mode : hint_enum(
	"multiply", "screen", "darken", "lighten", "difference",
	"exclusion", "overlay", "hard_light", "soft_light",
	"color_dodge", "linear_dodge", "color_burn", "linear_burn") = 0;

vec4 multiply(vec4 base, vec4 blend) { return base * blend; }
vec4 screen(vec4 base, vec4 blend) { return 1.0 - (1.0 - base) * (1.0 - blend); }
vec4 darken(vec4 base, vec4 blend) { return min(base, blend); }
vec4 lighten(vec4 base, vec4 blend) { return max(base, blend); }
vec4 difference(vec4 base, vec4 blend) { return abs(base - blend); }
vec4 exclusion(vec4 base, vec4 blend) { return base + blend - 2.0 * base * blend; }
vec4 overlay(vec4 base, vec4 blend){ vec4 limit = step(0.5, base); return mix(2.0 * base * blend, 1.0 - 2.0 * (1.0 - base) * (1.0 - blend), limit); }
vec4 hard_light(vec4 base, vec4 blend) { vec4 limit = step(0.5, blend); return mix(2.0 * base * blend, 1.0 - 2.0 * (1.0 - base) * (1.0 - blend), limit); }
vec4 soft_light(vec4 base, vec4 blend){ vec4 limit = step(0.5, blend); return mix(2.0 * base * blend + base * base * (1.0 - 2.0 * blend), sqrt(base) * (2.0 * blend - 1.0) + (2.0 * base) * (1.0 - blend), limit); }
vec4 color_dodge(vec4 base, vec4 blend) { return base / (1.0 - blend); }
vec4 linear_dodge(vec4 base, vec4 blend) { return base + blend; }
vec4 color_burn(vec4 base, vec4 blend){ return 1.0 - (1.0 - base) / blend; }
vec4 linear_burn (vec4 base, vec4 blend) { return base + blend - 1.0; }

vec4 get_mode(vec4 screenColor, vec4 color) {
	switch (mode) {
		case 0: return multiply(screenColor, color);
		case 1: return screen(screenColor, color);
		case 2: return darken(screenColor, color);
		case 3: return lighten(screenColor, color);
		case 4: return difference(screenColor, color);
		case 5: return exclusion(screenColor, color);
		case 6: return overlay(screenColor, color);
		case 7: return hard_light(screenColor, color);
		case 8: return soft_light(screenColor, color);
		case 9: return color_dodge(screenColor, color);
		case 10: return linear_dodge(screenColor, color);
		case 11: return color_burn(screenColor, color);
		case 12: return linear_burn(screenColor, color);
		default: return multiply(screenColor, color);
	}
}

void fragment() {
	vec4 screenColor = texture(SCREEN, SCREEN_UV);
	COLOR.rgb = get_mode(screenColor, COLOR).rgb;
}