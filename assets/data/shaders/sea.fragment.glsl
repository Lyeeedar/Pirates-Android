#ifdef GL_ES
	precision mediump float;
#endif
			
uniform vec3 u_colour;

uniform sampler2D u_texture;

varying vec2 v_pos;
			
void main() 
{
	gl_FragColor.rgb = texture2D(u_texture, v_pos).rgb * u_colour;
	gl_FragColor.a = 1.0;
}