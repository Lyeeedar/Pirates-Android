attribute vec3 a_position;

const float pi = 3.14159;

uniform float delta;
uniform int numWaves;
uniform float amplitude[8];
uniform float wavelength[8];
uniform float speed[8];
uniform vec2 direction[8];

uniform int u_posx;
uniform int u_posz;
uniform mat4 u_mvp;

uniform vec3 u_viewPos;

varying float v_vposLen;
varying vec3 v_pos;
varying vec3 v_normal;

float wave(int i, float x, float y) 
{
    float frequency = 2.0*pi/wavelength[i];
    float phase = speed[i] * frequency;
    float theta = dot(direction[i], vec2(x, y));
    return amplitude[i] * sin(theta * frequency + delta * phase);
}

float waveHeight(float x, float y) 
{
    float height = 0.0;
    for (int i = 0; i < numWaves; ++i)
        height += wave(i, x, y);
    return height;
}

float dWavedx(int i, float x, float y) {
    float frequency = 2.0*pi/wavelength[i];
    float phase = speed[i] * frequency;
    float theta = dot(direction[i], vec2(x, y));
    float A = amplitude[i] * direction[i].x * frequency;
    return A * cos(theta * frequency + delta * phase);
}

float dWavedy(int i, float x, float y) {
    float frequency = 2.0*pi/wavelength[i];
    float phase = speed[i] * frequency;
    float theta = dot(direction[i], vec2(x, y));
    float A = amplitude[i] * direction[i].y * frequency;
    return A * cos(theta * frequency + delta * phase);
}

vec3 waveNormal(float x, float y) {
    float dx = 0.0;
    float dy = 0.0;
    for (int i = 0; i < numWaves; ++i) {
        dx += dWavedx(i, x, y);
        dy += dWavedy(i, x, y);
    }
    vec3 n = vec3(-dx, 1.0, -dy);
    return normalize(n);
}
			
void main() 
{
    vec4 position = vec4(a_position.x+u_posx, 0.0, a_position.z+u_posz, 1.0);
    position.y = a_position.y+waveHeight(position.x, position.z);
	gl_Position = u_mvp * position;

    v_pos = position.xyz;
    v_vposLen = length(u_viewPos-position.xyz);
    v_normal = vec3(0.0, 1.0, 0.0);//waveNormal(position.x, position.z);
}