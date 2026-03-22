shader_type canvas_item;
uniform float blink_speed = 6;

void vertex() {
	
	float blink = (sin(TIME * blink_speed) + 1.0) / 2.0;
	COLOR = vec4(1.0, 0.0, 0.0, 1.0 * blink);
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
