#ifdef GL_ES
	precision mediump float;
#endif

uniform vec3 u_colour;

void main()
{
	gl_FragColor.rgb = u_colour;

	gl_FragColor.a = 1.0;

}