
attribute vec3 a_position;
attribute vec3 a_normal; 
attribute vec2 a_texCoord0;

uniform mat4 u_pv;
uniform mat4 u_mm;
uniform mat3 u_nm;

varying vec2 v_texCoords;
varying vec3 v_pos;
varying vec3 v_normal;

void main()
{	
	vec4 worldPos = u_mm * vec4(a_position, 1.0);
	gl_Position = u_pv * worldPos;

	v_pos = worldPos.xyz;
	v_texCoords = a_texCoord0;
	v_normal = normalize(u_nm * a_normal);
}