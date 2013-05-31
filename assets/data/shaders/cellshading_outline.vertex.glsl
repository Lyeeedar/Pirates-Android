
attribute vec3 a_position;
attribute vec3 a_normal; 
attribute vec2 a_texCoord0;

uniform vec3 u_cam;
uniform mat4 u_pv;
uniform mat4 u_mm;

uniform float u_thickness_max;
uniform float u_thickness_min;

void main()
{	
	vec4 worldPos = u_mm * vec4(a_position, 1.0);
	float thickness = mix(u_thickness_max, u_thickness_min, length(u_cam-worldPos.xyz)*0.005);
	worldPos = u_mm * vec4(a_position+(a_normal*thickness), 1.0);
	gl_Position = u_pv * worldPos;
}