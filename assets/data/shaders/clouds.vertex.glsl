
attribute vec3 a_position;

uniform mat4 u_mm;
uniform mat4 u_mvp;
uniform vec3 u_pos;
uniform float u_time;

varying vec2 v_texCoords;

void main()
{	
	vec4 tpos = u_mm * vec4(a_position, 0.0);
	vec4 position = u_mvp * vec4(tpos.xyz+u_pos, 1.0);
	gl_Position = position.xyww;

	float slope = (tpos.y*tpos.y)/100.0;

	v_texCoords = (((tpos+u_pos/50.0f).xz)+vec2(u_time))/slope;
}