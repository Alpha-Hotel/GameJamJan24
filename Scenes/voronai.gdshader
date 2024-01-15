shader_type canvas_item;

const vec2 left = vec2(300, 500);
const vec2 right = vec2(700, 500);

const vec2 array_of_vertices[4] = {vec2(300, 500), vec2(0, 0), vec2(700, 300), vec2(0,0)};

vec4 color_sort(float x, float y) {
	int current_check = 0;
	for (int i = 1; i < array_of_vertices.length(); i++){
		if (distance(array_of_vertices[current_check], vec2(x*1152.0, y*648.0)) > distance(array_of_vertices[i], vec2(x*1152.0, y*648.0))) {
		current_check = i;
	}
	switch (current_check) {
		case 0:
			return vec4(0.372549, 0.619608, 0.627451, 1); //CADET_BLUE 
		case 1:
			return vec4(1, 0.498039, 0.313726, .8); // CORAL
		case 2:
			return vec4(0.333333, 0.419608, 0.184314, 1); //DARK_OLIVE_GREEN
	}
	}
}



void vertex() {
	// Called for every vertex the material is visible on.

}

void fragment() {
	// Called for every pixel the material is visible on.

	if (distance(left, vec2(UV.x*1152.0, UV.y*648.0)) < distance(array_of_vertices[2], vec2(UV.x*1152.0, UV.y*648.0))) {
		//COLOR = vec4(0.941176, 0.372549, 1, 1);
	}  else {
		//COLOR = vec4(.3,.2,1,1);
	}
	COLOR = color_sort(UV.x, UV.y);
}


//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
