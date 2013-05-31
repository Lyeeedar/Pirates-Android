#ifdef GL_ES
	precision mediump float;
#endif

uniform sampler2D u_texture;

varying vec2 v_texCoords;
varying vec3 v_light;

void main()
{	
	gl_FragColor.rgb = texture2D(u_texture, v_texCoords).rgb * v_light;
	gl_FragColor.a = 1.0;

}