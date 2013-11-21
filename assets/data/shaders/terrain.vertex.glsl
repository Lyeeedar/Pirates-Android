attribute vec3 a_position;

uniform sampler2D u_hm1;
uniform sampler2D u_hm2;
uniform sampler2D u_hm3;

uniform float u_seaFloor;

uniform vec3 u_hm_pos[3];
uniform float u_hm_height[3];
uniform float u_hm_scale[3];

uniform int u_posx;
uniform int u_posz;
uniform mat4 u_mvp;

uniform vec3 u_viewPos;

varying float v_vposLen;
varying vec3 v_pos;
varying vec3 v_normal;
			
void main() 
{
    vec4 position = vec4(a_position.x+u_posx, 0.0, a_position.z+u_posz, 1.0);

    float height = u_seaFloor;
    
    vec2 movedPos = (position.xz-u_hm_pos[0].xz)/u_hm_scale[0];
    if (movedPos.x > 0.0 && movedPos.y > 0.0 && movedPos.x < 1.0 && movedPos.y < 1.0) 
    {
        vec3 tmp = texture2D(u_hm1, movedPos);
        float texCol = (tmp.r+tmp.g+tmp.b)/3.0;
        height = u_seaFloor+texCol*u_hm_height[0];
    }

    movedPos = (position.xz-u_hm_pos[1].xz)/u_hm_scale[1];
    if (movedPos.x > 0.0 && movedPos.y > 0.0 && movedPos.x < 1.0 && movedPos.y < 1.0) 
    {
        vec3 tmp = texture2D(u_hm2, movedPos);
        float texCol = (tmp.r+tmp.g+tmp.b)/3.0;
        height = u_seaFloor+texCol*u_hm_height[1];
    }

    movedPos = (position.xz-u_hm_pos[2].xz)/u_hm_scale[2];
    if (movedPos.x > 0.0 && movedPos.y > 0.0 && movedPos.x < 1.0 && movedPos.y < 1.0) 
    {
        vec3 tmp = texture2D(u_hm3, movedPos);
        float texCol = (tmp.r+tmp.g+tmp.b)/3.0;
        height = u_seaFloor+texCol*u_hm_height[2];
    }

    position.y = a_position.y+(height);
    gl_Position = u_mvp * position;

    v_pos = position.xyz;
    v_vposLen = length(u_viewPos-position.xyz);
    v_normal = vec3(0.0, 1.0, 0.0);
}