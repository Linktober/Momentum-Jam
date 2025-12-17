shader_type canvas_item;

// --- Uniforms --- /
uniform float influence: hint_range(0.0, 1.0, 0.1) = 0.5;
uniform float saturation: hint_range(1.0, 10.0, 0.1) = 2.0;

// --- Functions --- //
vec3 hsv2rgb(vec3 _c) {
    vec4 _K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 _p = abs(fract(_c.xxx + _K.xyz) * 6.0 - _K.www);
    return _c.z * mix(_K.xxx, clamp(_p - _K.xxx, 0.0, 1.0), _c.y);
}

void fragment() {
	COLOR.rgb += influence * hsv2rgb(vec3(SCREEN_UV.x + SCREEN_UV.y, saturation, 1.0));
}