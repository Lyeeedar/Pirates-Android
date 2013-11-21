#ifdef GL_ES
	precision mediump float;
#endif
			
uniform vec3 colour_sea;
uniform float sea_height;
			
uniform vec3 colour_sky;

varying float v_height;
			
void main() 
{
	vec3 colour = vec3(0.0);

	if (v_height < sea_height)
	{
		colour = colour_sea;
	}
	else
	{
		colour = colour_sky;
	}

	gl_FragColor.a = 1.0;
	gl_FragColor.rgb = colour;
}