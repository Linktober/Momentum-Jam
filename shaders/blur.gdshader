shader_type canvas_item;


uniform float blur_radius : hint_range(0.0, 100.0) = 5.0;
uniform int sample_count : hint_range(3, 9) = 5;

varying vec4 modulate;


void vertex() {
    modulate = COLOR;
}


void fragment() {
	vec4 blurred_color = vec4(0.0);
	float total_weight = 0.0;

	float center = float(sample_count - 1) * 0.5;
	float spread = blur_radius / center;

	for (float x = 0.0; x < float(sample_count); x++) {
		for (float y = 0.0; y < float(sample_count); y++) {
			// sample between pixels for hardware filtering
			vec2 offset = vec2(x - center, y - center) * spread;

			// gaussian weights
			float dist_sq = dot(offset, offset);
			float weight = exp(-dist_sq / (2.0 * blur_radius * blur_radius));

			blurred_color += texture(TEXTURE, UV + offset * TEXTURE_PIXEL_SIZE) * weight;
			total_weight += weight;
		}
	}

	COLOR = (blurred_color / total_weight) * modulate;
}