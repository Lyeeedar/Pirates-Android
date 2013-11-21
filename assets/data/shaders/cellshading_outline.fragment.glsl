#ifdef GL_ES
	precision mediump float;
#endif

uniform vec3 u_colour;

uniform vec3 fog_colour;
uniform float fog_min;
uniform float fog_max;

varying float v_vposLen;

void main()
{
	float fog_fac = (v_vposLen - fog_min) / (fog_max - fog_min);
	fog_fac = clamp (fog_fac, 0.0, 1.0);

	gl_FragColor.rgb = mix(u_colour, fog_colour, fog_fac);

	gl_FragColor.a = 1.0;

}