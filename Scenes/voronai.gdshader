shader_type canvas_item;

const vec2 left = vec2(300, 500);
const vec2 right = vec2(700, 500);

const vec2 array_of_vertices[4] = {vec2(300, 500), vec2(1000, 0), vec2(700, 300), vec2(0,0)};

vec4 color_sort(float x, float y) {
	// Color sort returns a vec4 compatible with COLOR based on how close the vector (x, y) is
	// to a list of vertices. 
	int current_check = 0;
	for (int i = 0; i < array_of_vertices.length(); i++){
		// Sorts closest node based on distance between two vectors
		if ( distance(array_of_vertices[current_check], vec2(x*1152.0, y*648.0)) > distance(array_of_vertices[i], vec2(x*1152.0, y*648.0)) ) {
		current_check = i;
		} 	
	}
	switch (current_check) {
		// Returns color based on current_check integer
		case 0:
			return vec4(0.372549, 0.619608, 0.627451, 1); //CADET_BLUE 
		case 1:
			return vec4(1, 0.498039, 0.313726, 1); // CORAL
		case 2:
			return vec4(0.333333, 0.419608, 0.184314, 1); //DARK_OLIVE_GREEN
		case 3:
			return vec4(0.498039, 1, 0, 1); // Chartreuse
			
	}
}



void vertex() {
	// Called for every vertex the material is visible on.
	
}

void fragment() {

	COLOR = color_sort(UV.x, UV.y);
}


//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
