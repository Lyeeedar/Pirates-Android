
attribute vec3 a_position;
attribute vec3 a_normal; 
attribute vec2 a_texCoord0;

uniform vec3 instance_position;

uniform mat4 u_pv;
uniform vec3 u_viewPos;

varying float v_vposLen;

varying vec2 v_texCoords;
varying vec3 v_pos;
varying vec3 v_normal;

void main()
{	
	vec4 worldPos = vec4(a_position+instance_position, 1.0);
	gl_Position = u_pv * worldPos;

	v_pos = worldPos.xyz;
	v_texCoords = a_texCoord0;
	v_normal = a_normal;

	v_vposLen = length(u_viewPos-worldPos.xyz);
}