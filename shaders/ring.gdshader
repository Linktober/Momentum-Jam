shader_type canvas_item;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;
uniform float speed = 1.0;

varying vec4 modulate;

void vertex() {
    modulate = COLOR;
}

// --- Functions --- //
vec3 hsv2rgb(vec3 _c) {
    vec4 _K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 _p = abs(fract(_c.xxx + _K.xyz) * 6.0 - _K.www);
    return _c.z * mix(_K.xxx, clamp(_p - _K.xxx, 0.0, 1.0), _c.y);
}

void fragment() {
	vec3 rainbow = hsv2rgb(vec3(UV.y + TIME * speed, 1.0, 1.0));
	vec4 screen_color = texture(screen_texture, SCREEN_UV);

	vec3 combined_rgb = screen_color.rgb + (rainbow * screen_color.a * modulate.a);

	COLOR.rgb = combined_rgb * modulate.rgb;
	COLOR.a = screen_color.a * modulate.a;
}