attribute vec3 a_position;
					
uniform mat4 u_mvp;
uniform mat4 u_v;
		
varying float v_height;
			
void main() {
	vec4 position = u_mvp * vec4(a_position, 1.0);
	gl_Position = position.xyww;
	v_height = a_position.y;//(u_v * vec4(a_position, 1.0)).y;
}