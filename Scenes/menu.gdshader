shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
//uniform float scale : hint_range(0.1, 10) = 1.0;
uniform sampler2D distortionTexture;

void fragment() {

	//vec4 pixelColor = texture(TEXTURE, UV * scale);
	//COLOR = pixelColor;
	//COLOR.rgb = COLOR.grb;
	vec2 distortedUV = SCREEN_UV + texture(distortionTexture, UV).g * 0.03;
	vec4 screenColor = texture(SCREEN_TEXTURE, distortedUV);
	COLOR = screenColor;
	
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
