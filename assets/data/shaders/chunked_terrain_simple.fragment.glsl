#ifdef GL_ES
	precision mediump float;
#endif

varying vec3 u_colour;

void main()
{	
	gl_FragColor = vec4(u_colour, 1.0);
}