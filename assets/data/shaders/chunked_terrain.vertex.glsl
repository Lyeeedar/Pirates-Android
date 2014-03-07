
attribute vec3 a_position;
attribute vec3 a_normal; 
attribute float a_texA0;
attribute float a_texA1;
attribute float a_texA2;

uniform mat4 u_pv;
uniform mat4 u_mm;

uniform vec3 u_viewPos;

varying float v_vposLen;

varying vec3 v_texAlphas;
varying vec3 v_texCoords;
varying vec3 v_pos;
varying vec3 v_normal;

void main()
{	
	vec4 worldPos = u_mm * vec4(a_position, 1.0);
	gl_Position = u_pv * worldPos;

	v_pos = worldPos.xyz;
	v_texCoords = worldPos.xyz;
	v_texAlphas = vec3(a_texA0, a_texA1, a_texA2);
	v_normal = ( u_mm * vec4( a_normal, 0.0 ) ).xyz;

	v_vposLen = length(u_viewPos-worldPos.xyz);
}