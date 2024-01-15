shader_type canvas_item;

const vec2 left = vec2(300, 500);
const vec2 right = vec2(700, 500);


void vertex() {
	// Called for every vertex the material is visible on.

}

void fragment() {
	// Called for every pixel the material is visible on.

	if (distance(left, vec2(UV.x*1152.0, UV.y*648.0)) < distance(right, vec2(UV.x*1152.0, UV.y*648.0))) {
		COLOR = vec4(0.941176, 0.372549, 1, 1);
	} else {
		COLOR = vec4(.3,.2,1,1);
	}
	
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
